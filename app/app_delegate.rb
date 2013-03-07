class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    list_controller = ListViewController.alloc.init
    thumbnails_controller = ThumbnailsViewController.alloc.init

    tab_controller = UITabBarController.alloc.init
    tab_controller.viewControllers = [list_controller, thumbnails_controller]

    @window.rootViewController = tab_controller
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible

    true
  end
end
