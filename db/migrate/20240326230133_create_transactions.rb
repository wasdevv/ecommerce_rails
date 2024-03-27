class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.references :wallet, null: false, foreign_key: true, type: :uuid
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
