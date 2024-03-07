class CreateActivityLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :activity_logs, id: :uuid do |t|
      t.references :user, null: false, foreign_key: { to_table: :users, type: :uuid }
      t.references :trackable, polymorphic: true, null: false
      t.integer :action
      t.text :details

      t.timestamps
    end
  end
end