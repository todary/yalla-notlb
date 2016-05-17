class CreateOrderMembers < ActiveRecord::Migration
  def change
    create_table :order_members do |t|
      t.references :order, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :status_user

      t.timestamps null: false
    end
  end
end
