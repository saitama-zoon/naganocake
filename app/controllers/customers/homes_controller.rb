class Customers::HomesController < ApplicationController

 def top
 	@categories = Category.where(is_effective: "true" )
    effective_products = Product.includes(:category).where(categories: {is_effective: true})
    @products = effective_products.where(is_sale_status: true).page(params[:page]).per(4)
    @title = "商品"
 end

 def about

 end
end
