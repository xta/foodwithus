class SessionsController < ApplicationController

  def new
    redirect_to "/auth/foursquare"
  end

  def create
    if user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Signed in!"
    else
      failure
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_path, notice: "An error has occurred. Please try again."
  end

end
