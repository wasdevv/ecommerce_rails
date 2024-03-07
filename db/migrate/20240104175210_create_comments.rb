class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.text :content
      t.uuid :user_id
      t.uuid :product_id

      t.timestamps
    end
  end
end
