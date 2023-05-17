class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items, id: :uuid do |t|
      t.string :product_name
      t.decimal :price
      t.integer :quantity
      t.references :order, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
