class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def is_signed_in?
    redirect_to root_path, notice: "You must be signed in." if current_user.nil?
  end

  def correct_user?
    redirect_to root_path unless current_user.id == params[:id].to_i
  end

end
