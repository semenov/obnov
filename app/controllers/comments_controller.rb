class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.post = Post.find(params[:post_id])
    @comment.user = current_user
    authorize! :create, @comment
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
  
  def destroy
    @stream = Stream.find_by_slug(params[:stream_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to([@stream, @post])
  end
end
