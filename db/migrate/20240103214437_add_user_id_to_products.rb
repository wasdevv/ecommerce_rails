class AddUserIdToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :user, null: false, foreign_key: true, type: :uuid
  end
end
