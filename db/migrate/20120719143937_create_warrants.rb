class CreateWarrants < ActiveRecord::Migration
  def change
    create_table :warrants do |t|
      t.date :date
      t.date :date_till
      t.integer :order_id
      t.integer :contact_id
    end
  end
end
