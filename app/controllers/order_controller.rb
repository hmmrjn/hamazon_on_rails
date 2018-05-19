class OrderController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(
      user_id: session[:user_id],
      cart_id: @current_cart.id,
      total_amount: get_cart_total_amount
    )
    @current_cart.cart_items.each do |cart_item|
      order.order_items.create(
        item_id: cart_item.item_id,
        quantity: cart_item.quantity,
        purchase_price: cart_item.item.price
      )
    end
    @current_cart = Cart.new
    session[:cart_id] = @current_cart.id
    flash[:success] = '注文を確定しました'
    redirect_to "/order/#{order.id}"
  end

  def get_cart_total_amount
    total_amount = 0
    @current_cart.cart_items.each do |cart_item|
      total_amount += cart_item.quantity * cart_item.item.price
    end
    total_amount
  end
end
