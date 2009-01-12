# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  layout 'application'

  protect_from_forgery
  before_filter :login_required
  filter_parameter_logging :password

  helper_method :logged_in?

  def login_required
    unless logged_in?
      redirect_to login_url
      return false
    end
  end

  def logged_in?
    !!session[:identity_url]
  end

  def authorized?
    logged_in?
  end
end
