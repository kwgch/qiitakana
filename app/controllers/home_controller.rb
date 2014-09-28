class HomeController < ApplicationController
  
  before_action :authenticate_user!
  
#   def index
#   end
  
  def index
    if signed_in?
#       @post  = current_user.posts.build
#       binding.pry
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
end
