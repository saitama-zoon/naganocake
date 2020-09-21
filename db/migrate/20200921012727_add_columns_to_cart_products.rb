class AddColumnsToCartProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_products, :customer_id, :integer
    add_column :cart_products, :product_id, :integer
    add_column :cart_products, :quantity, :integer
  end
end