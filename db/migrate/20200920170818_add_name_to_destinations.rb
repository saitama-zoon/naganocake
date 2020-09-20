class AddNameToDestinations < ActiveRecord::Migration[5.2]
  def change
    add_column :destinations, :name, :string
  end
end
