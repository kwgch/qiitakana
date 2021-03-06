class PostsController < ApplicationController
  include PostsHelper

  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :set_user, without: [:preview]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :build_post, only: [:create]
  before_action :correct_user, only: [:update, :destroy]
  before_action :set_state, only: [:create, :update]

  def drafts
    @posts = current_user.posts.drafted.listing.paginate(page: params[:page])
  end

  def posted
    @posts = current_user.posts.published.posted.listing.paginate(page: params[:page])
    render 'drafts'
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
    if @post.save(post_params)
      msg = { notice: "#{t @post.state_text}しました。" }
    else
      msg = { alert: "#{t @post.state_text}に失敗しました。" }
    end
    redirect_to edit_user_post_path(current_user, @post), msg
  end

  def update
    if @post.update(post_params)
      msg = { notice: "#{t @post.state_text}しました。" }
    else
      msg = { alert: "#{t @post.state_text}に失敗しました。" }
    end
    if !params[:post][:comment]
      redirect_to edit_user_post_path(current_user, @post), msg
    else
      redirect_to user_post_path(@post.user.username, @post), msg
    end
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

    def build_post
      @post = current_user.posts.build(post_params)
    end

    def set_user
      @user = User.find_first_by_auth_conditions(login: params[:user_id])
    end

    def post_params
      params.require(:post).permit(:title, :markdown, :body, :image, tags_attributes: [:id, :name], comments_attributes: [:id, :post_id, :body])
    end

    def correct_user
      if params[:post][:comment] && @post.user != current_user
        redirect_to user_post_path(@user.username, @post), alert: '操作権限がありません'
      end
    end

    def set_state
      @post.set_state(params[:post])
    end

end