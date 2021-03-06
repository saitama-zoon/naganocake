class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!

  def index
    @orders = Order.all.page(params[:page]).per(10)
    #binding.pry
  end

  def individual
    @orders = Order.where(customer_id: params[:id]).page(params[:page]).per(10)
    render 'index'
  end

  def show
    @order = Order.find(params[:id])
    @product = @order.order_products
  end

  def update
    order = Order.find(params[:id])

    #以下、文字列で値を取得する...
    order_str = params[:order][:order_status]
    #@product_str = @order.find(id: [:order][:id][:product_status])
    #@product_str = params[:order][:order_products_attributes][:product_status]

    products=order.order_products
    #binding.pry
    if order_str == "Payment_confirmation"
    products.update_all(product_status: 1)
    end
    order.update(order_params)
    redirect_to admins_order_path
  end

  private

  def order_params
    params.require(:order).permit(
      :created_at, :postal_code, :address, :name, :shipping, :payment_method, :order_status
      )
  end

end
