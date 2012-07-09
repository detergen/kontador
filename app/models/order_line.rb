class OrderLine < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	def to_label
		"OrderLines"
	end
end
