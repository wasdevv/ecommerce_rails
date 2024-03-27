class CreateWallets < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.decimal :balance, precision: 10, scale: 2

      t.timestamps
    end
  end
end
