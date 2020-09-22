class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_products, dependent: :destroy

  has_many :products, :through => :order_products

  enum payment_method: {
    Not_set: 0,
    Bank_transfer: 1,
    Credit_card: 2
  }

  enum order_status: {
    Waiting_for_payment: 0,
    Payment_confirmation: 1,
    In_production: 2,
    Ready_to_ship: 3,
    Sent: 4
  }
end
