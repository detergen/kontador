class AddPriceTotalVatTotalToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_price, :decimal

    add_column :orders, :vat, :decimal

  end
end
