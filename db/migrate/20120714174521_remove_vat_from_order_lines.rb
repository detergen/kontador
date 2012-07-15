class RemoveVatFromOrderLines < ActiveRecord::Migration
  def up
	  remove_column :order_lines, :vat
        remove_column :order_lines, :vat_rate
        remove_column :order_lines, :vat_out
      end

  def down
    add_column :order_lines, :vat_out, :boolean
    add_column :order_lines, :vat_rate, :decimal
    add_column :order_lines, :vat, :decimal
  end
end
