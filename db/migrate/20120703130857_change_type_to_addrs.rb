class ChangeTypeToAddrs < ActiveRecord::Migration
  def up
	  rename_column :addrs, :type, :typeofaddr
  end

  def down
  end
end
