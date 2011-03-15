class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.post = Post.find(params[:post_id])
    @comment.user = current_user
    @comment.save
    redirect_to([@comment.post.stream, @comment.post])
  end
end
