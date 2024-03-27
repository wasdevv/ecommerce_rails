class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         after_create :create_wallet_on_user

         has_one :cart, dependent: :destroy
         has_many :products, dependent: :destroy
         has_many :orders

         has_one :wallet

         has_many :favorites
         has_many :favorited_products, through: :favorites, source: :product

         enum role: { user: 0, admin: 1 }

         has_many :activity_logs, as: :trackable, class_name: 'ActivityLog'
         has_many :comments, dependent: :destroy
         
         def admin?
          role == 'admin'
         end

         private

         def create_wallet_on_user
          Wallet.create(user: self, balance: 0.00)
         end
end
