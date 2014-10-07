class HomeController < ApplicationController
  before_action :signed_in_user
  before_action :set_tab_class
  
  def index
      @feed_items = wrap_query current_user.feed
  end
  
  def public_feeds
    @feed_items = wrap_query Post.all
    render action: 'index'
  end
  
  def mine
    @feed_items = wrap_query current_user.posts
    render action: 'index'
  end

  def wrap_query(q)
    q.paginate(page: params[:page])
  end
  
  def set_tab_class
    @tab_class = "#{params[:action]}-tab"
  end
  
end
