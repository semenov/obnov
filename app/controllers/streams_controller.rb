class StreamsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @streams = Stream.all
  end

  def show
    @stream = Stream.find(params[:id])
    @post = Post.new
  end

  def new
    @stream = Stream.new
  end

  def edit
    @stream = Stream.find(params[:id])
  end

  def create
    @stream = Stream.new(params[:stream])

    if @stream.save
      redirect_to(@stream, :notice => 'Stream was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @stream = Stream.find(params[:id])

    if @stream.update_attributes(params[:stream])
      redirect_to(@stream, :notice => 'Stream was successfully updated.')
    else
      render :action => "edit" 
    end
  end

  def destroy
    @stream = Stream.find(params[:id])
    @stream.destroy
    redirect_to(streams_url)
  end
end
