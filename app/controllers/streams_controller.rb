class StreamsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @streams = current_user.streams
  end

  def show
    @stream = Stream.find_by_slug(params[:id])
    authorize! :read, @stream
    @post = Post.new
    @pipe = {
      :stream_id => @stream.id.to_s
    }
  end

  def new
    @stream = Stream.new
  end

  def edit
    @stream = Stream.find_by_slug(params[:id])
    authorize! :edit, @stream
  end

  def create
    @stream = Stream.new(params[:stream])
    @stream.user = current_user

    if @stream.save
      redirect_to(@stream, :notice => 'Stream was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @stream = Stream.find_by_slug(params[:id])
    authorize! :update, @stream

    if @stream.update_attributes(params[:stream])
      redirect_to(@stream, :notice => 'Stream was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    @stream = Stream.find_by_slug(params[:id])
    authorize! :destroy, @stream
    @stream.destroy
    redirect_to(streams_url)
  end
end
