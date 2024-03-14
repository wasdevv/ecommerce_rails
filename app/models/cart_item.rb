class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product, uniqueness: { scope: :cart_id } # adding 1 item p/click in link_to
                                                      # can change in _cart_table.html.erb
                                                      has_one_attached :image

                                                      def image_webp
                                                        image.variant(format: "webp")
                                                      end
end