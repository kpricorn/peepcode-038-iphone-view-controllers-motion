class ThumbnailsViewController < UIViewController

  def init
    super
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('Thumbnails',
                                                       image: '45-movie-1'.uiimage,
                                                       tag: 1)
    self
  end

  def viewDidLoad
    super
    # Do any additional setup after loading the view.
  end

  def viewDidUnload
    super
    # Release any retained subviews of the main view.
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    interfaceOrientation == UIInterfaceOrientationPortrait
  end
end
