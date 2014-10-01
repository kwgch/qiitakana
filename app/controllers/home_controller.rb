class HomeController < ApplicationController
  
#   before_action :authenticate_user!
  
#   def index
#   end
  
  def index
    if signed_in?
#       @post  = current_user.posts.build
#       binding.pry
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      redirect_to new_user_session_path
    end
  end
  
  def public_feeds
    @feed_items = Post.find_all.paginate(page: params[:page])
  end
  
  def mine
    @feed_items = current_user.posts.paginate(page: params[:page])
  end
  
end
