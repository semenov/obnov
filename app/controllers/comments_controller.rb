class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment.post = Post.find(params[:post_id])
    @comment.save
    redirect_to([@comment.post.stream, @comment.post])
  end
end
