class Order < ApplicationRecord
  belongs_to :user
  
  has_many :order_items, dependent: :destroy
  has_many :cart_items, through: :order_items
  has_many :activity_logs, as: :trackable, dependent: :destroy

  before_save :revenue_calc

  validate :sufficient_balance

  def sufficient_balance
    errors.add(:base, "Insufficient balance") user.wallet.present? && user.wallet.balance < total_revenue
  end
  
  def total_revenue
    order_items.sum(&:price)
  end

  private

  def revenue_calc
    self.revenue = order_items.sum { |item| item.quantity * item.product.price }
  end
end
