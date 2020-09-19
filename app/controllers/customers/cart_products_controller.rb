class Customers::CartProductsController < ApplicationController

	before_action :setup_cart_product!, only: [:create]

	def index
		customer=current_customer
		@cart_product=customer.cart_product.all
	end

	def creat
		# カートに追加ボタンで実行、すでに同種類の商品が入っている場合は数量を追加
		@product = Product.find(params[:id])
		if @cart_product.blank?
			@cart_product=CartProduct.new
			@cart_product.customer_id = current_user.id
			@cart_prodect.product_id = @product.id
		end
		@cart_product.quantity += params[:quantity].to_i
		@cart_product.save
		redirect_to cart_products_path
	end

	def update
	end

	def destroy
	end

	private
	def cart_product_params
		params.require(:cart_product).permit(:cusomer_id, :product_id, :quantity)
	end

	def setup_cart_product!
    @cart_product = CartProduct.find_by(product_id: params[:id])
  	end
  	#カートに入れる際、カート内に同じ商品が入っている場合はその情報を所得

end
