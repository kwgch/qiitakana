class HomeController < ApplicationController
  before_action :signed_in_user
  before_action :set_tab_class
  
  def index
    paging current_user.feed
  end
  
  def public_feeds
    paging Post.all
    render action: 'index'
  end
  
  def mine
    paging current_user.posts
    render action: 'index'
  end

  private

    def set_tab_class
      @tab_class = "#{params[:action]}-tab"
    end

    def paging(q)
      @feed_items = q.paginate(page: params[:page])
    end
  
end
