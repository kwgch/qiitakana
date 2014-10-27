class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tab_class

  def index
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def public_feeds
    @feed_items = Post.all.paginate(page: params[:page])
    render action: 'index'
  end

  def mine
    @feed_items = current_user.posts.paginate(page: params[:page])
    render action: 'index'
  end

  private

    def set_tab_class
      @tab_class = "#{params[:action]}-tab"
    end

end
