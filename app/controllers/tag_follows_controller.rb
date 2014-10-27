class TagFollowsController < ApplicationController
  before_action :set_tag

  def create
    current_user.tag_follow!(@tag)
  end

  def destroy
    current_user.tag_unfollow!(@tag)
  end

private

  def set_tag
    @tag = Tag.find(params[:tag_follow][:tag_id])
  end
end
