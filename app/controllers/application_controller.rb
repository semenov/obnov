class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def initialize
    super
    @pipe = {}
  end
    
  def after_sign_in_path_for(resource_or_scope)
    streams_path
  end
end
