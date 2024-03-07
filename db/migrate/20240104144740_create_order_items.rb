class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid :order_id
      t.uuid :product_id
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
