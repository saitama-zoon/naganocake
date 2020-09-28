class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :orders,
    dependent: :destroy
  has_many :destinations,
    dependent: :destroy

 enum is_member: {Available: true, Invalid: false}
 validates :is_member, inclusion: { in: ["Available", "Invalid"] }
  #有効会員はtrue、退会済み会員はfalse
   def active_for_authentication?
        super && (self.is_member === "Available")
   end
  #is_memberが有効の場合は有効会員(ログイン可能)

  has_many :cart_products, dependent: :destroy

  validates :first_name,
    presence: true
  validates :address,
    presence: true
  validates :postal_code,
    presence: true,
    format:{with:/\A\d{7}\z/}
  VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
  validates :phone_number, presence: true,
    format: { with: VALID_PHONE_REGEX }
  validates :first_name_kana,
    format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'フリガナ（セイ）はカタカナで入力して下さい。'}
  validates :last_name_kana,
    format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'フリガナ（メイ）はカタカナで入力して下さい。'}
end