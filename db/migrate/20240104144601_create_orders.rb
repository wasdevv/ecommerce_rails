class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid :user_id
      t.decimal :revenue, precision: 10, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
