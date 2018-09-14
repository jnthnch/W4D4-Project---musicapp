class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    #create a session if they logged in correctly
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if user.nil?
      flash.now[:errors] = ['Invalid Credentials']
      render :new
    else
      log_in_user!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    current_user.reset_session_token!
    #session in line 23 is the cookie on the user's computer
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
