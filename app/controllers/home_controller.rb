class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @feed_items = current_user.feed.paginate(page: params[:page])
  end

  def public_feeds
    @feed_items = Post.all.paginate(page: params[:page])
    render 'index'
  end

  def mine
    @feed_items = current_user.posts.paginate(page: params[:page])
    render 'index'
  end

  def stock
    @feed_items = current_user.stock_posts.paginate(page: params[:page])
    render 'index'
  end
end
