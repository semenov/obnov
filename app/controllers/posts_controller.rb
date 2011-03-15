class PostsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
  end
  
  def show
    @stream = Stream.find(params[:stream_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def create
    @post = Post.new(params[:post])
    @post.stream = Stream.find(params[:stream_id])
    @post.user = current_user
    @post.save
    redirect_to(@post.stream)
  end

  def update
  end

  def destroy
  end

end
