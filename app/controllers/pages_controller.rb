class PagesController < ApplicationController
  
  def index
    if user_signed_in?
      redirect_to streams_path
    else
      render :layout => 'basis'
    end
  end

end
