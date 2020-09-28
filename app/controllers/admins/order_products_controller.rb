class Admins::OrderProductsController < ApplicationController
	before_action :authenticate_admin!
  	def update
  		order_product=OrderProduct.find(params[:id])
  		order_product.update(order_product_params)
  		order=Order.find(order_product.order_id)
  		order_products=order.order_products.pluck(:product_status)

  		if order_products.all?{|f| f == "Made"}
  			order.update(order_status: 3)

  		elsif params[:order_product][:product_status] == 'In_production'
  			order.update(order_status: 2)
  		end
  		redirect_to admins_order_path(order)
  	end

  	private

  	def order_product_params
    	params.require(:order_product).permit(:product_status)
  	end
end
