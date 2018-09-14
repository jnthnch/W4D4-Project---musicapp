class ApplicationController < ActionController::Base

  helper_method :logged_in?, :current_user

  def current_user
    #is there a session token???
    #set session token to @current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    #is a current_user ???
    !!current_user
  end

  def log_in_user!(user)
    #log in the user! and give their cookie a new session token
    session[:session_token] = user.reset_session_token!
  end

  def require_user!
    #if there isn't a user, redirect them
    redirect_to new_session_url if current_user.nil?
  end
end
