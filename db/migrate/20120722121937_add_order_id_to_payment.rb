class AddOrderIdToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :order_id, :integer

    add_column :payments, :debet, :boolean

	remove_column :payments, :created_at
	remove_column :payments, :updated_at
  end
end
