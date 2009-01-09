class SessionsController < ApplicationController
  protect_from_forgery :except => [:create, :destroy]

  skip_before_filter :login_required, :only => [:new, :create]

  def new
  end

  def create
    if using_open_id?
      open_id_authentication
    else
      render :action => :new
    end
  end

  def destroy
    session[:identity_url] = nil
    redirect_to(login_url)
  end
  protected
  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        session[:identity_url] = identity_url
        redirect_to(root_url)
      else
        flash[:error] = result.message
        redirect_to(new_session_url)
      end
    end
  end
end
