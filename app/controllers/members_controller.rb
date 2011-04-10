class MembersController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @stream = Stream.find_by_slug(params[:stream_id])
    authorize! :read, @stream
  end

  def create
    @stream = Stream.find_by_slug(params[:stream_id])
    unless @stream.is_applicant? current_user
      @stream.applicants << current_user 
      @stream.save
    end
    
    redirect_to(@stream, :notice => 'Заявка добавлена на рассмотрение.')
  end
  
  def update
    @stream = Stream.find_by_slug(params[:stream_id])
    @user = User.find(params[:id])
    authorize! :manage, @stream
    
    if @stream.is_applicant? @user
      @stream.accept_application @user
    end
    
    redirect_to stream_members_path(@stream)
  end

  def destroy
    @stream = Stream.find_by_slug(params[:stream_id])
    @user = User.find(params[:id])
    authorize! :manage, @stream
    
    @stream.applicants.delete @user
    @stream.members.delete @user
    @stream.save
    
    redirect_to stream_members_path(@stream)
  end

end
