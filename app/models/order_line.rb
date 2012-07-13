class OrderLine < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	def to_label
		"OrderLines"
	end

	def sum_price
		#self.qty*self.price
	end
end
