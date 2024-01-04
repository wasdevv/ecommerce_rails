class Order < ApplicationRecord
  belongs_to :user
  
  has_many :order_items, dependent: :destroy
  has_many :cart_items, through: :order_items
  has_many :activity_logs, as: :trackable, dependent: :destroy

  
end
