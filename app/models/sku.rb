class Sku < ActiveRecord::Base
	has_many :products
end
