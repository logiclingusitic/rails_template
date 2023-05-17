class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A(([A-Za-z0-9]*\.+*_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\+)|([A-Za-z0-9]+\+))*[A-Z‌​a-z0-9]+@{1}((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,4}\z/i

  validates :email, presence: true, length: {maximum: 100},
  uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX}

  has_secure_password

  has_one :cart

  has_many :cart_items, dependent: :destroy

  has_many :orders, dependent: :destroy

end
