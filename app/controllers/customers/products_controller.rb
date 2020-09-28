class Customers::ProductsController < ApplicationController

  def index
    @categories = Category.where(is_effective: "true")
    effective_products = Product.includes(:category).where(categories: {is_effective: true})
    @products = effective_products.where(is_sale_status: true).page(params[:page]).per(8)
    @title = "商品"
    #binding.pry
  end

  def show
  	@product = Product.find(params[:id])
  	@cart_product = CartProduct.new
  	@categories = Category.where(is_effective: "true")
    @tax = @product.price * 1.1
  end
  #ジャンル検索機能
  def search
  	@products = Product.where(category_id: params[:id]).where(is_sale_status: "true").page(params[:page]).per(8)
    @quantity = Product.where(category_id: params[:id]).count
    @categories = Category.where(is_effective: "true")
    category = Category.find(params[:id])
    @title = category.name
    render 'index'
  end

  def name_search

    #ジャンルが非選択時、全てのジャンルを定義
    if params[:category_id] == ""
      category = Product.all
    elsif
      #販売中の商品のみ取得
      effective_category = Product.includes(:category).where(categories: {is_effective: true})
      #販売中かつ有効なジャンルのみ取得
      category = effective_category.where(category_id: params[:category_id])
    end
    #販売中かつ有効なジャンルの商品より、指定された名称の商品を取得
    product = category.where(['products.name LIKE?', "%#{params[:search]}%"])
    product_on_sales = product.where(is_sale_status: "true")
    @products = product_on_sales.page(params[:page]).per(8)
    #binding.pry
    @quantity = product_on_sales.count
    @categories = Category.where(is_effective: "true")
    @title = "検索結果"
    render action: :index
  end

  private
  def product_params
   params.require(:product).permit(:name, :introduction, :image, :price)
  end

end