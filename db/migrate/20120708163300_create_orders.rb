class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.date :order_date
      t.date :document_date
      t.text :note
      t.string :status
      t.string :tag
      t.integer :from_id
      t.integer :to_id
      t.integer :recipient_id
    end
  end
end
