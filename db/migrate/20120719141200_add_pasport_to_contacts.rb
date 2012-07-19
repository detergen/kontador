class AddPasportToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :pasp_series, :string

    add_column :contacts, :pasp_number, :string

    add_column :contacts, :pasp_date, :string

    add_column :contacts, :pasp_given, :string

    add_column :contacts, :pasp_kp, :string

    add_column :contacts, :address, :string

  end
end
