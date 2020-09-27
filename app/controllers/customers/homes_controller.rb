class Customers::HomesController < ApplicationController
 def top
 	@products = Product.page(params[:page]).per(4)
 	@categories = Category.where(is_effective: "true" )
 end
 def about

 end
end
