class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user_logged_in

  def set_user_logged_in
    if session[:user_id]
      @user_logged_in = User.find(session[:user_id])
    end
  end
end
