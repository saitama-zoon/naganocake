class Category < ApplicationRecord
  #アソシエーション
  has_many :products
  #バリデーション
  validates :name, presence: true
  validates :is_effective, inclusion: { in: [true, false] }

end