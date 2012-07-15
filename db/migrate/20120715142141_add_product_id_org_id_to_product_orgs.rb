class AddProductIdOrgIdToProductOrgs < ActiveRecord::Migration
  def change
    add_column :product_orgs, :product_id, :integer
    add_column :product_orgs, :organization_id, :integer

	remove_column :product_orgs, :created_at
	remove_column :product_orgs, :updated_at


  end
end
