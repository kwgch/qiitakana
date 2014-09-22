class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :correct_user, only: [:update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  
  def index
    @posts = @user.posts.all
  end

  def show
    @post.comments.build # これ！
  end

  def new
    @post = current_user.posts.build
    @post.tags.build # これ！
  end

  def edit
    @post.tags.build # これ！
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to [current_user, @post], notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [current_user, @post], notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_url(current_user), notice: '投稿は削除されました' }
#       format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
#       @post = current_user.posts.find(params[:id])
    end

  def set_user
    @user = User.find_first_by_auth_conditions(login: params[:user_id])
#     binding.pry
    raise ActiveRecord::RecordNotFound if @user.blank?
  end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
#             params.require(:post).permit(:id, posts_attributes:[:id, :title, :body, :publish_on, comments_attributes: [:id, :post_id, :body, :_destroy]])
      params.require(:post).permit(:title, :body, :publish_on, :tag_list, tags_attributes: [:id, :name], comments_attributes: [:id, :post_id, :body, :_destroy])
    end
  
  def correct_user
    post = current_user.posts.find_by(id: params[:id])
    redirect_to user_posts_path(@user.username), alert: '操作権限がありません' if post.nil?
  end
end
