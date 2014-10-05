class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_logged_in?
  	if(!session[:logged_in])
  		redirect_to root_url, :alert => "You must be logged in to view this page."
  	end
  end

  def admin_user
  @current_user = session[:logged_in]
end
helper_method :admin_user
end
