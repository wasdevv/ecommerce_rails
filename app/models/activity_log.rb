class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  enum action: { product_created: 0, product_updated: 1, product_deleted: 2, product_added: 3 }
end
