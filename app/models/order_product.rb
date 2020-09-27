class OrderProduct < ApplicationRecord
  belongs_to :order

  enum product_status: {
    Cannot_be_started: 0,
    Waiting_for_production: 1,
    In_production: 2,
    Made: 3
  }
end
