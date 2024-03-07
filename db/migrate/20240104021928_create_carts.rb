class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
