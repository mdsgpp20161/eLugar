class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private

  # def current_user_face
  # 	#@current_user_face||= User.find_by(session[:user_id])
  # 	if @current_user_face.nil?
  #     @current_user_face = User.find_by(id: session[:user_id])
  #   else
  #     @current_user_face
  #   end
  # end
  # helper_method :current_user_face
  include SessionsHelper


end

