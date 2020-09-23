class Destination < ApplicationRecord

  belongs_to :customer

  def full_dest
    self.postal_code + " " + self.address + " " + self.name
  end
end
