class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user_logged_in
  before_action :set_current_cart

  def set_user_logged_in
    if session[:user_id]
      @user_logged_in = User.find(session[:user_id])
    end
  end

  def set_current_cart
    if session[:cart_id]
      @current_cart = Cart.find(session[:cart_id])
    else
      @current_cart = Cart.create
      session[:cart_id] = @current_cart.id
    end
  end

  def require_login
    unless @user_logged_in
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
    end
  end
end
