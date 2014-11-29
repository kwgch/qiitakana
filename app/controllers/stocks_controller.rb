class StocksController < ApplicationController
  before_action :set_post

  def create
    current_user.stock!(@post)
  end

  def destroy
    current_user.unstock!(@post)
  end

private

  def set_post
    @post = Post.find((params[:stock] && params[:stock][:post_id]) || params[:id])
  end
end
