class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @feed_items = current_user.feed.usual.paginate(page: params[:page])
  end

  def public_feeds
    @feed_items = Post.usual.paginate(page: params[:page])
    render 'index'
  end

  def mine
    @feed_items = current_user.posts.usual.paginate(page: params[:page])
    render 'index'
  end

  def stock
    @feed_items = current_user.stock_posts.usual.paginate(page: params[:page])
    render 'index'
  end
end
