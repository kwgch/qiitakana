class PostsController < ApplicationController
  include PostsHelper
  
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_user, without: [:preview]
  before_action :correct_user, only: [:update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  
#   def index
#     @posts = @user.posts.all
#   end

  def show
    @post.comments.build
  end

  def new
    @post = current_user.posts.build
    @post.tags.build
  end

  def edit
    @post.tags.build
  end

  def create
    @post = current_user.posts.build(post_params)
    post_processing_of @post.save(post_params)
  end

  def update
    post_processing_of @post.update(post_params)
  end

  def destroy
    @post.destroy
    redirect_to user_posts_url(current_user), notice: '投稿は削除されました'
  end

  def preview
    render text: Post.markdown_render(params[:markdown])
  end
  
  private
    def set_post
      @post = Post.unscoped.includes(:tags).find(params[:id])
    end

    def set_user
      @user = User.find_first_by_auth_conditions(login: params[:user_id])
    end

    def post_params
      params.require(:post).permit(:title, :markdown, :body, tags_attributes: [:id, :name], comments_attributes: [:id, :post_id, :body])
    end

    def correct_user
      post = current_user.posts.find_by(id: params[:id])
      redirect_to user_posts_path(@user.username), alert: '操作権限がありません' if post.nil?
    end
  
    def post_processing_of(success)
      if success
        msg = { notice: '投稿しました。' }
      else
        msg = { alert: '投稿に失敗しました。' }
      end
      redirect_to edit_user_post_path(current_user, @post), msg
    end
end
