class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items, class_name: 'CartItem', dependent: :destroy
  has_many :products, through: :cart_items, dependent: :destroy
  has_many :order_tiems, through: :order
  
  has_many :activity_logs, as: :trackable, dependent: :destroy
end
