class AddOrganizationIdToBankAccs < ActiveRecord::Migration
  def change
    add_column :bankaccs, :organization_id, :integer

  end
end
