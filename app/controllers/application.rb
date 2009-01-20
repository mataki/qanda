# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  layout 'application'

  init_gettext "qanda"

  protect_from_forgery
  before_filter :login_required
  filter_parameter_logging :password
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  helper_method :logged_in?

  def login_required
    unless logged_in?
      flash[:notice] = _("please login.")
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

  def current_user
    session[:identity_url]
  end

  def render_404
    render :file => "public/404.html"
    return false
  end
end
