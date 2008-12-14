# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  layout 'application'
  before_filter :logged_in?

  protect_from_forgery

  def logged_in?
    if session[:identity_url].blank?
      redirect_to new_session_url
    else
      true
    end
  end
end
