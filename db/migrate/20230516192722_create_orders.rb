class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :customer_name
      t.text :shipping_address
      t.string :phone_number
      t.string :payment_method
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
