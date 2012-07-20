class OrderLinesController < ApplicationController
  active_scaffold :order_line do |conf|

	  conf.list.columns << :sum_price
	  #conf.columns << :sum_price

	  conf.list.columns = [
		  :product,
		  :qty,
		  :price,
		  :sum_price,
	  ]

	  conf.columns[:price].options = {:format => :currency}
	  conf.columns[:qty].options[:format] = "%.4f"
	  conf.columns[:price].calculate = :sum
	  conf.columns[:qty].calculate = :sum

  end
end 
