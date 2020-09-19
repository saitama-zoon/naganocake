class Product < ApplicationRecord

	has_many :cart_products, dependent: :destroy
	has_many :order_products
  	belongs_to :category

end