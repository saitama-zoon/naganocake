class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, dependent: :destroy

  has_many :products, :through => :order_products
  accepts_nested_attributes_for :order_products


  validates :address, presence: true, length: {maximum: 35, minimum: 2}
  validates :postal_code, presence: true, length: {maximum: 10, minimum: 2}
  validates :name, presence: true, length: {maximum: 50, minimum: 3}

  enum payment_method: {
    Not_set: 0,
    Bank_transfer: 1,
    Credit_card: 2,
  }

  enum order_status: {
    Waiting_for_payment: 0,
    Payment_confirmation: 1,
    In_production: 2,
    Ready_to_ship: 3,
    Sent: 4
  }
#修正

end
