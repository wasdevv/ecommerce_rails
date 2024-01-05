class Product < ApplicationRecord
    belongs_to :user

    has_many :cart_items
    has_many :carts, through: :cart_items
    has_many :comments

    validates :name, presence: true
    validates :quantity, numericality: { only_integer: true}
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates :description, presence: true

    has_many :activity_logs, as: :trackable, dependent: :destroy
end
