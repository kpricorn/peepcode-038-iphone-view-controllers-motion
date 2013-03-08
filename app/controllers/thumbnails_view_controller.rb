class ThumbnailsViewController < UIViewController

  attr_accessor :newsItems

  def init
    super
    self.navigationItem.title = 'Thumbnails'
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Thumbnails',
                                                       image: '45-movie-1'.uiimage,
                                                       tag: 1)
    App.notification_center.observe DidClickOnItem do |notification|
      item = notification.object
      webViewController = WebViewController.alloc.initWithNewsItem(item)
      self.navigationController << webViewController
    end

    self
  end

  def loadView
    self.view = ThumbnailsView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
  end

  def viewDidAppear(animated)
    loadData
    super
  end

  def loadData
    if @newsItems.nil?
      @newsItems = NewsItem.loadRecentWithDelegate(
        &method(:receivedNewsItems))
    else
      receivedNewsItems(@newsItems)
    end
  end

  def receivedNewsItems(receivedNewsItems)
    @newsItems = receivedNewsItems
    self.view.updateContent(@newsItems)
  end
end
