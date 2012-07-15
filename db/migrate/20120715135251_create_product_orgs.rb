class CreateProductOrgs < ActiveRecord::Migration
  def change
    create_table :product_orgs do |t|

      t.timestamps
    end
  end
end
