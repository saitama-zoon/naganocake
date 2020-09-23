class Customers::HomesController < ApplicationController
 def top
 	@products = Product.page(params[:page]).per(4)
 	@categories = Category.all
 end
 def about

 end
end
