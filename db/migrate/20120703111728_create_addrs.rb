class CreateAddrs < ActiveRecord::Migration
  def change
    create_table :addrs do |t|
      t.string :name
      t.string :type
      t.string :postindex
      t.string :string1
      t.string :string2
      t.string :key
      t.text :note
      t.integer :organization_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
