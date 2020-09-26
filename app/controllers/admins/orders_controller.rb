class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!

  def index
    @orders = Order.all.page(params[:page]).per(10)
    #binding.pry
  end

  def show
    @order = Order.find(params[:id])
    @product = @order.order_products
  end

  def update
    @order = Order.find(params[:id])

    #以下、文字列で値を取得する...
    @order_str = params[:order][:order_status]
    @product_str = params[:order][:product_status]

    @order.order_products.each do |order_product|
      case @order_str
        #これでcase文は機能している...
        when "Waiting_for_payment"
          order_product.product_status = 0
          @hello = "hello!"
        when 1
          order_product.product_status = 1
        when 4
          order_product.product_status = 4
      end
    end

    case @product_str
      when 2
        @order.order_status = 2
      when 3
        @order.order_status = 3
    end

    binding.pry
    @order.update(order_params)
    redirect_to admins_order_path
  end

  private

  def order_params
    params.require(:order).permit(
      :created_at, :postal_code, :address, :name, :shipping, :payment_method, :order_status,
      order_products_attributes: [:id, :product_id, :order_id, :quantity, :price_with_tax, :product_status]
      )
  end
end
