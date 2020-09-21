class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :name
      t.string :postal_code
      t.text :address
      t.integer :shipping,default: 800
      t.integer :payment_method,default: 0
      t.integer :order_status,default: 0
      t.timestamps
    end
  end
end
