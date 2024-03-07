class CreateCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_items, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid :cart_id
      t.uuid :product_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
