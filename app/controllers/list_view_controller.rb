class ListViewController < UIViewController

  def init
    super
    self.navigationItem.title = 'List'
    self.tabBarItem = UITabBarItem.alloc.initWithTitle('List',
                                                       image: '179-notepad'.uiimage,
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
