class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :short_name
      t.string :full_name
      t.string :to_name
      t.string :post
      t.string :phone1
      t.string :phone2
      t.string :phone3
      t.string :phone4
      t.string :key
      t.string :tag
      t.text :note
      t.integer :organization_id

      t.timestamps
    end
  end
end
