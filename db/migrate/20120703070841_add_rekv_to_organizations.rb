class AddRekvToOrganizations < ActiveRecord::Migration
  def change
	    add_column :organizations, :opf, :string
	    add_column :organizations, :short_name, :string
	    add_column :organizations, :full_name, :string
	    add_column :organizations, :inn, :string
	    add_column :organizations, :kpp, :string
	    add_column :organizations, :ogrn, :string
	    add_column :organizations, :okpo, :string
  end
end
