class WebViewController < UIViewController
  def initWithNewsItem newsItem
    init
    @newsItem = newsItem
    self.title = newsItem.title
    self
  end

  def loadView
    self.view = UIWebView.alloc.init
  end

  def viewDidLoad
    unless @newsItem.nil?
      request = NSURLRequest.requestWithURL @newsItem.url
      view.loadRequest request
    end
    super
  end
end
