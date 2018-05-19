class CartController < ApplicationController
  before_action :setup_cart_item!, only: [:add_item, :update_item, :remove_item]

  def show
    @cart_items = @current_cart.cart_items
  end

  def add_item
    if @cart_item.blank?
      @cart_item = @current_cart.cart_items.new(item_id: params[:item_id], quantity: params[:quantity])
    else
      @cart_item.quantity += params[:quantity]
    end
    @cart_item.save
    redirect_to cart_path
  end

  def update_item
    @cart_item.update(quantity: params[:quantity])
    redirect_to cart_path
  end

  def remove_item
    @cart_item.destroy
    redirect_to cart_path
  end

  def setup_cart_item!
    @cart_item = @current_cart.cart_items.find_by(item_id: params[:item_id])
  end
end
