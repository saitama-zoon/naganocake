class Customers::ProductsController < ApplicationController

  def index
    @products = Product.all
    @categories = Category.all
    @products = Product.page(params[:page]).per(8)
  end

  def show
  	@product = Product.find(params[:id])
  	@cart_product = CartProduct.new
  	@categories = Category.all
    @tax = @product.price * 1.1
  end
  #ジャンル検索機能
  def search
  	@products = Product.where(category_id: params[:id])
    @quantity = Product.where(category_id: params[:id]).count
    @categories = Category.where(is_effective: "true" )
    #binding.pry
    render 'index'
  end

  private
  def product_params
   params.require(:product).permit(:name, :introduction, :image, :price)
  end

end