class ThumbnailsView < UIView

  THUMBNAIL_VIEW_COLUMN_COUNT = 2.0
  include BW::KVO

  def initWithFrame(frame, delegate:aDelegate)
    super
    @content = []
    @buttons = []
    #delegate = aDelegate;
    frameAtOrigin = CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)
    @scrollView = UIScrollView.alloc.initWithFrame(frameAtOrigin)
    @scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth
    @scrollView.autoresizesSubviews = true
    @scrollContentView = UIView.alloc.initWithFrame(frameAtOrigin)
    @scrollView.addSubview(@scrollContentView)
    addSubview(@scrollView)
    self.autoresizesSubviews = true
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth
    self
  end

  def updateContent(newContent)
    if @content != newContent
      removeEventObservers
      @content = newContent
      addEventObservers
    end
    removeExistingButtons
    rebuildButtons
  end

  def addEventObservers
    @content.each_with_index do |dataItem, index|
      observe(dataItem, :image) do |old_value, new_value|
        button = @buttons.at(index)
        button.setBackgroundImage(new_value, forState:UIControlStateNormal)
      end
    end
  end

  def removeEventObservers
    @content.each do |dataItem|
      unobserve(dataItem, 'image')
    end
  end


  def rebuildButtons
    @buttons = []
    buttonWidth = (self.frame.size.width) / THUMBNAIL_VIEW_COLUMN_COUNT
    buttonHeight = buttonWidth * (3.0/2.0)

    rows = (@content.count / THUMBNAIL_VIEW_COLUMN_COUNT).ceil
    contentHeight = rows * buttonHeight
    expandedFrame = CGRectMake(0.0, 0.0, self.frame.size.width, contentHeight)
    @scrollContentView.frame = expandedFrame
    @content.each_with_index do |dataItem, i|
      column = (i % THUMBNAIL_VIEW_COLUMN_COUNT.to_i)
      row    = (i / THUMBNAIL_VIEW_COLUMN_COUNT.to_i)

      buttonFrame = CGRectMake((column * buttonWidth), (row * buttonHeight),
                               buttonWidth, buttonHeight)

      button = UIButton.alloc.initWithFrame(buttonFrame)
      button.backgroundColor = UIColor.blueColor
      button.setBackgroundImage(dataItem.image, forState:UIControlStateNormal)
      button.when(UIControlEventTouchUpInside) do
        p 'button clicked'
        #if ([delegate respondsToSelector:@selector(didClickOnItem:)])
        #{
        #id <TFThumbnailViewDataItem> item = [content objectAtIndex:[sender tag]];
        #[delegate didClickOnItem:item];
        #}
      end
      button.tag = i

      @scrollContentView.addSubview(button)
      @buttons << button
    end
    @scrollView.setContentSize(@scrollContentView.frame.size)
  end

  def removeExistingButtons
    @scrollContentView.subviews.each do |child|
      if child.is_a? UIButton
        child.removeFromSuperview
      end
    end
  end
end
