class MainController < ApplicationController
  def index
  end

  def login
  end

  def create_login
  	if(params[:username] == Rails.application.config.admin_username && params[:password] == Rails.application.config.admin_password)
	  session[:logged_in] = true
	  redirect_to root_url, :notice => "Logged in!"
	else
	  flash.alert = "Invalid credentials"
	  render "login"
	end
  end

  def logout
  	session[:logged_in] = nil
  	redirect_to root_url, :notice => "Logged out!"
  end
end
