class AddBankAccIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :bankacc_id, :integer

  end
end
