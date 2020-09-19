class CartProduct < ApplicationRecord
	belong_to :customer
	belong_to :product
end
