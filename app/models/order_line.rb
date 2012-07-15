class OrderLine < ActiveRecord::Base
	belongs_to :order
	belongs_to :product

	def to_label
		"OrderLines"
	end

	def sum_price
		self.qty*self.price
	end

	def after_save
		self.update_total_price
	end

	def after_destroy
		self.update_total_price
	end

	def update_total_price
		self.order.total_price = self.order.order_lines.sum(self.sum_price)
		self.order.save
	end

end
