class Product < ApplicationRecord
  #アソシエーション
  has_many :cart_products, dependent: :destroy
  has_many :customers, through: :cart_products
  has_many :order_products
  has_many :products, through: :order_products
  belongs_to :category
  attachment :image
  #バリデーション
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_sale_status, inclusion: { in: [true, false] }

end