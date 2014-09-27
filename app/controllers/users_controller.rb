# class UsersController < DeviseController
class UsersController < ApplicationController
#   include DeviseController 
#   before_action :authenticate_user!
  
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    if params[:id]
#       @user = User.find(params[:id])
      @user = User.find_by!(username: params[:id])
      @posts = @user.posts.paginate(page: params[:page])
    else
#       @user = User.find(params[:username])
      @user = User.find_by(username: params[:username])
      @posts = @user.posts.paginate(page: params[:page])
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
    
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
end
