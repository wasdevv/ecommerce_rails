class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  enum action: {  product_created: 0,
                  product_updated: 1,
                  product_deleted: 2,
                  product_added: 3,
                  created_cart: 4,
                  added_to_cart: 5,
                  removed_from_cart: 6,
                  deleted_cart: 7,
                  created_order: 8,
                  created_history: 9,
                  removed_all_items: 10,
                  created_commentary: 11,
                  edited_commentary: 12,
                  deleted_commentary: 13,
                  favorite_product: 14,
                  favorite_removed: 15
                }
end
