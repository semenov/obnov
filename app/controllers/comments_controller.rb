class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.post = Post.find(params[:post_id])
    @comment.user = current_user
    @comment.save
    
    comment_html = render_to_string @comment
    
    Juggernaut.publish("posts/#{@comment.post.id}", { :html => comment_html })
    redirect_to([@comment.post.stream, @comment.post]) if !request.xhr?
  end
end
