class Order < ApplicationRecord
  belongs_to :user
  
  has_many :order_items, dependent: :destroy
  has_many :cart_items, through: :order_items
  has_many :activity_logs, as: :trackable, dependent: :destroy

  before_save :revenue_calc

  # 

  private

  def revenue_calc
    self.revenue = order_items.sum { |item| item.quantity * item.product.price }
  end
end
