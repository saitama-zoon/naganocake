class Destination < ApplicationRecord

  belongs_to :customer
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :postal_code,format:{with:/\A\d{7}\z/}

  def full_dest
    self.postal_code + " " + self.address + " " + self.name
  end
end
