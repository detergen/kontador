class AddToAccFromAccIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :to_acc_id, :integer

    add_column :payments, :from_acc_id, :integer

  end
end
