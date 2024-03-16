class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid :user_id
      t.decimal :total_price, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
