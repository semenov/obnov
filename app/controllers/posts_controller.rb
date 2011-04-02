class PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
  end
  
  def show
    @stream = Stream.find(params[:stream_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
    @pipe = {
      :stream_id => @stream.id.to_s,
      :post_id => @post.id.to_s
    }
  end

  def create
    @post = Post.new(params[:post])
    @post.stream = Stream.find(params[:stream_id])
    @post.user = current_user
    @post.save
    
    post_html = render_to_string @post
    
    Juggernaut.publish("streams/#{@post.stream.id}", { :event => 'posts/create', :html => post_html })
    if request.xhr?
      render :json => @post
    else
      redirect_to(@post.stream)
    end
  end

  def update
  end

  def destroy
  end

end
