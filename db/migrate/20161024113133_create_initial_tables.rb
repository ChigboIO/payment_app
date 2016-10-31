class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price

      t.timestamps null: false
    end

    create_table :orders do |t|
      t.string :status, default: 'pending'
      t.decimal :total_price
      t.string :stripeToken
      t.text :result

      t.timestamps null: false
    end

    create_table :line_items do |t|
      t.belongs_to :order, index: true, foreign_key: true
      t.belongs_to :product, index: true, foreign_key: true
      t.decimal :price

      t.timestamps null: false
    end
  end
end
