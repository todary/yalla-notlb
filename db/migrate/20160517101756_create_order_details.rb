class CreateOrderDetails < ActiveRecord::Migration
  def change
    create_table :order_details do |t|
      t.string :item
      t.integer :amount
      t.float :price
      t.text :comment
      t.references :order, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
