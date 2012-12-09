class AddParentIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :parent_id, :integer

  end
end
