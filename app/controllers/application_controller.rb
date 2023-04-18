class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :current_user?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def require_user
    return if logged_in?

    flash[:danger] = 'You must be logged id to perform that action'
    redirect_to root_path
  end

  def current_user?(user)
    return true if !current_user.nil? && current_user.id == user.id
  end
end
