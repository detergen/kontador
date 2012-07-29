class RenameFieldsFromPayments < ActiveRecord::Migration
  def up
    remove_column :payments, :to_acc_id, :integer
    remove_column :payments, :from_acc_id, :integer
    add_column :payments, :toacc_id, :integer
    add_column :payments, :fromacc_id, :integer
  end

  def down
  end
end
