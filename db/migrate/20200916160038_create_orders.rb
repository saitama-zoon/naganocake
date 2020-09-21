class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
    	t.integer :customer_id
    	t.string :name
    	t.string :postal_code
    	t.text :address
    	t.integer :shipping
    	t.integer :payment_method
    	t.integer :order_status
      t.timestamps
    end
  end
end
