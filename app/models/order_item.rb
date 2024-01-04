class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  has_many :order_items
end
