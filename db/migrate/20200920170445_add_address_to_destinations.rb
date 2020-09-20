class AddAddressToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :address, :text
  end
end
