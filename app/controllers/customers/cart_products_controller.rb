class Customers::CartProductsController < ApplicationController
	before_action :authenticate_customer!
	before_action :setup_cart_product!, only: [:create]

	def index
		@cart_products=current_customer.cart_products

	end

	def create
		# カートに追加ボタンで実行、すでに同種類の商品が入っている場合は数量を追加
		product = Product.find(params[:id])
		if @cart_product.blank?
			@cart_product=CartProduct.new(cart_product_params)
			@cart_product.customer_id = current_customer.id
			@cart_product.product_id = product.id
			@cart_product.price_with_tax = product.price*1.1
		end

		@cart_product.quantity += 1.to_i
		@cart_product.save
		redirect_to cart_products_path
	end

	def update
		cart_product=current_customer.cart_product(params[:id])
		cart_product.update(cart_product_params)
		redirecy_to cart_products_path
	end

	def destroy
		cart_product=current_customer.cart_product.find(params[:id])
		#item.idから消去したいカート内商品のレコードを所得
		cart_product.destroy
		#選択したカート内商品を削除
		redirect_to cart_products_path
		#カートページに遷移
	end

	def destroy_all
		cart_products=current_customer.cart_product.all
		#ログインユーザーのカート内商品を全て所得
		cart_products.destroy
		#全て消去
		redirect_to cart_products_path
		#カートページに遷移
	end

	private
	def cart_product_params
		params.require(:cart_product).permit(:cusomer_id, :product_id, :quantity)
	end

	def setup_cart_product!
    @cart_product = current_customer.cart_product.find_by(product_id: params[:id])
  	end
  	#カートに入れる際、カート内に同じ商品が入っている場合はその情報を所得

end
