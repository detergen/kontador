class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.integer :order_id
      t.integer :product_id
      t.decimal :qty
      t.decimal :price
      t.decimal :vat
      t.decimal :vat_rate
      t.boolean :vat_out
    end
  end
end
