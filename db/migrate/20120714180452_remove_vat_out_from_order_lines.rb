class RemoveVatOutFromOrderLines < ActiveRecord::Migration
  def up
    remove_column :order_lines, :vat_out
      end

  def down
    add_column :order_lines, :vat_out, :boolean
  end
end
