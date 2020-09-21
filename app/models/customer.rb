class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :destinations, dependent: :destroy

  enum is_member: {Available: true, Invalid: false}
  #有効会員はtrue、退会済み会員はfalse
   def active_for_authentication?
        super && (self.is_member === "Available")
    end
  #is_memberが有効の場合は有効会員(ログイン可能)
end
