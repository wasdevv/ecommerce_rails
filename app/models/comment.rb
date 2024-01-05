class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  has_many :activity_logs, as: :trackable, dependent: :destroy

  validates :content, presence: true
end
