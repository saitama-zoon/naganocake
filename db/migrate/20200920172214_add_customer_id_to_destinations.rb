class AddCustomerIdToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :customer_id, :integer
  end
end
