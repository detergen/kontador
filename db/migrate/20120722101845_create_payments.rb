class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :note
      t.decimal :amount
      t.string :tag
      t.string :status
      t.date :pay_date

      t.timestamps
    end
  end
end
