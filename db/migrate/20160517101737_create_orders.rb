class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name
      t.string :resturant
      t.boolean :status ,default: true
      t.references :user, index: true, foreign_key: true
      t.string :image

      t.timestamps null: false
    end
  end
end
