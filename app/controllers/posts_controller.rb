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
    
    post_html = render_to_string @post
    
    Juggernaut.publish("streams/#{@post.stream.id}", { :html => post_html })
    if !request.xhr?
      redirect_to(@post.stream)
    end
  end

  def update
  end

  def destroy
  end

end
