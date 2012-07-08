class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.string :name
    end
  end
end
