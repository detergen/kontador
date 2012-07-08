class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :articul
      t.integer :ean13
      t.text :note
      t.decimal :weight
      t.decimal :x
      t.decimal :y
      t.decimal :z
      t.boolean :service
      t.boolean :purchased
      t.integer :sku_id

    end
  end
end
