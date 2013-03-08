class NewsItem
  attr_accessor :title
  attr_accessor :text
  attr_accessor :url
  attr_accessor :fromUser
  attr_accessor :screenshotURL
  attr_accessor :thumbnailImage
  attr_accessor :image
  attr_accessor :connection
  attr_accessor :receivedData

  def self.loadRecentWithDelegate(&block)
    BW::HTTP.get("http://news.peepcode.com/snaps.json") do |response|
      if response.ok?
        json = BW::JSON.parse(response.body.to_str)
        news_items = json.first[:topfunky].map do |item_json|
          n = NewsItem.new
          n.title = item_json['snap']['title']
          n.text = item_json['snap']['text']
          n.url = item_json['snap']['url'].nsurl
          n.fromUser = item_json['snap']['from_user']
          n.screenshotURL  = "http://api1.thumbalizr.com/?url=#{n.url.absoluteString}".nsurl
          n
        end
        block.call(news_items)
      end
    end
  end

  def image
    unless @image.nil?
      return @image
    end

    Dispatch::Queue.concurrent.async do
      image_data = NSData.alloc.initWithContentsOfURL(@screenshotURL)
      p image_data
      if image_data
        @image = UIImage.alloc.initWithData(image_data)
      end
    end
    'default-320x480.png'.uiimage
  end

  def thumbnailImage
    unless @thumbnailImage.nil?
      return @thumbnailImage
    end

    'default-43x43.png'.uiimage
    #NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self 
    #[op setQueuePriority:NSOperationQueuePriorityVeryLow];
    #[[HROperationQueue sharedOperationQueue] addOperation:op];
    #[op release];
  end
end
