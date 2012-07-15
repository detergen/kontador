class ProductsController < ApplicationController
  active_scaffold :product do |conf|

	  conf.list.columns = [:name, :articul, :price, :weight, :tag ]
	  conf.columns = [:name, :articul, :price, :sku, :weight, :x, :y, :z, :note, :purchased, :service,:tag ]

	  conf.columns[:price].options = {:format => :currency}
	  conf.columns[:sku].form_ui = :select

	  conf.create.columns.add_subgroup "Dimension" do |dimension_group|
		  dimension_group.add :x, :y, :z
	  end

	  conf.update.columns.add_subgroup "Dimension" do |dimension_group|
		  dimension_group.add :x, :y, :z
	  end

  end
end 
