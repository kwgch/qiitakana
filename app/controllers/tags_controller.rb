class TagsController < ApplicationController
  
  def show
    @feed_items = Post.tagged_with(params[:id]).paginate(page: params[:page])
    @tag = Tag.find_by(name: params[:id])
  end
  
end
