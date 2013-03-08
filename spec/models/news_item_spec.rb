describe NewsItem do
  describe '#loadRecentWithDelegate' do
    it 'loads news items' do
      NewsItem.loadRecentWithDelegate do |news_items|
        @news_items = news_items
        resume
      end

      wait_max 5.0 do
        @news_items.count.should == 15
      end

    end
  end
end
