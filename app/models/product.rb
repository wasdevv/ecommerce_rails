class Product < ApplicationRecord
    belongs_to :user

    validates :name, presence: true
    validates :quantity, numericality: { only_integer: true}
    validates :price, numericality: { greater_than_or_equal_to: 0 }
    validates :description, presence: true
end
