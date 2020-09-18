class Admins::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
  	@product = Product.find(params[:id])
  	@products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update
    redirect_to products_path
  end

　private
  def product_params
    params.require(:product).permit(:name, :introduction, :category_id, :image, :price, :is_sale_status)
  end

end