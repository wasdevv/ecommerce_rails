class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product, presence: true # adding 1 item p/click in link_to
                                                      # can change in _cart_table.html.erb
end
