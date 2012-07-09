class Product < ActiveRecord::Base
	belongs_to :sku
	has_many :order_line
end
