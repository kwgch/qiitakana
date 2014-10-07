# class UsersController < DeviseController
class UsersController < ApplicationController
#   include DeviseController 
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    if params[:id]
#       @user = User.find(params[:id])
      @user = User.find_by!(username: params[:id])
      @feed_items = @user.posts.paginate(page: params[:page])
    else
#       @user = User.find(params[:username])
      @user = User.find_by(username: params[:username])
      @feed_items = @user.posts.paginate(page: params[:page])
    end
  end
  
  def following
    @title = "Following"
    @user = User.find_by(username: params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
    
  def followers
    @title = "Followers"
    @user = User.find_by(username: params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def following_tags
    @title = "Following Tags"
    @user = User.find_by(username: params[:id])
    @tags = @user.tags.paginate(page: params[:page])
    render 'show_follow_tags'
  end
  
end
