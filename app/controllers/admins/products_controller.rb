class Admins::ProductsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @products = Product.all
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
    @products = Product.all
    @tax = @product.price * 1.1
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    @product.save
    redirect_to admins_products_path
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    redirect_to admins_products_path
  end

  private
  def product_params
    params.require(:product).permit(:name, :introduction, :category_id, :image, :price, :is_sale_status)
  end

end