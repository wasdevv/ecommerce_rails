class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price
      t.text :description

      t.timestamps
    end
  end
end
