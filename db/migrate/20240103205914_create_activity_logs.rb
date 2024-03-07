class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs, id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.uuid :user_id
      t.references :trackable, polymorphic: true, null: false
      t.integer :action
      t.text :details

      t.timestamps
    end
  end
end