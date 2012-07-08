class AddBikToBankAccs < ActiveRecord::Migration
  def change
    add_column :bankaccs, :bik, :string

  end
end
