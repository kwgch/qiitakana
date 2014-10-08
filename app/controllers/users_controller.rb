class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :following, :followers, :following_tags]
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @feed_items = @user.posts.paginate(page: params[:page])
  end
  
  def following
    @users = @user.followed_users.paginate(page: params[:page])
    @title = "#{@user.username}がフォロー中のユーザー"
    render 'show_follow'
  end
    
  def followers
    @users = @user.followers.paginate(page: params[:page])
    @title = "#{@user.username}のフォロワー"
    render 'show_follow'
  end
  
  def following_tags
    @tags = @user.tags
    @title = "#{@user.username}がフォロー中のタグ"
    render 'show_follow_tags'
  end
  
  private 
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
  
end
