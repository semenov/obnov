class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.post = Post.find(params[:post_id])
    @comment.user = current_user
    @comment.save
    
    comment_html = render_to_string @comment
    
    Juggernaut.publish("streams/#{@comment.post.stream.id}", { 
      :event => 'comments/create', :post_id => @comment.post.id, :html => comment_html })
    
    if request.xhr?
      render :json => @comment
    else
      redirect_to([@comment.post.stream, @comment.post])
    end
  end
end
