class Customers::ProductsController < ApplicationController

  def index
    @products = Product.all
    @categories = Category.all
  end

  def show
  	@product = Product.find(params[:id])
  	@cart_product = CartProduct.new
  	@categories = Category.all
  end
  #ジャンル検索機能
  def search
  	@products = Product.where(category_id: params[:fotmat])
    @quantity = Product.where(category_id: params[:fotmat]).count
    @categories = Category.where(is_sale_status: true)
    render 'index'
  end

  private
  def product_params
   params.require(:product).permit(:name, :introduction, :image, :price)
  end

end