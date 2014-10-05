class TagFollowsController < ApplicationController
  
  before_action :set_tag
  
  def create
#     binding.pry
#     @tag = Tag.find(params[:tag_follow[:tag_id])
    current_user.tag_follow!(@tag)
    respond_to do |format|
      format.html { redirect_to @tag }
      format.js
    end
  end

  def destroy
#     @tag = Tag.find(params[:tag_follow[:tag_id])
    current_user.tag_unfollow!(@tag)
    respond_to do |format|
      format.html { redirect_to @tag }
      format.js
    end
  end
  
  def set_tag
#     binding.pry
    @tag = Tag.find(params[:tag_follow][:tag_id])
  end
  
end