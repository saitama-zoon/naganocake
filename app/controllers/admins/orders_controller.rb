class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!

  def index
    @orders = Order.all
    #binding.pry
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    redirect_to admins_order_path
    #redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(
      :created_at, :postal_code, :address, :name, :shipping, :payment_method, :order_status,
      order_products_attributes: [:product_id, :order_id, :quantity, :price_with_tax, :product_status]
      )
  end
end
