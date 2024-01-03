class ActivityLog < ApplicationRecord
  belongs_to :user
  belongs_to :trackable
end
