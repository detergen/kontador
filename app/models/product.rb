class Product < ActiveRecord::Base
	belongs_to :sku
	has_many :order_line

	#has_many :product_orgs
	#has_many :organizations, :through => :product_orgs, :readonly => false

end
