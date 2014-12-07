class PostsController < ApplicationController
  include PostsHelper

  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_user, without: [:preview]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:update, :destroy]

  def drafts
    @posts = current_user.posts.unscoped.drafts.paginate(page: params[:page])
  end

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
    setTemporary
    post_processing_of @post.save(post_params)
  end

  def update
    setTemporary
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
#       unless @post.user == current_user
#         redirect_to user_post_path(@user.username, @post), alert: '操作権限がありません'
#       end
    end

  def post_processing_of(success)
    verb = params[:temporary] ? '一時保存' : '投稿'
    if success
      msg = { notice: "#{verb}しました。" }
    else
      msg = { alert: "#{verb}に失敗しました。" }
    end
    if @post.user == current_user
      redirect_to edit_user_post_path(current_user, @post), msg
    else
      redirect_to user_post_path(@post.user.username, @post)
    end
  end

  def setTemporary
    @post.temporary = params[:temporary] ? true : false
  end

end
