class OrderLinesController < ApplicationController
  active_scaffold :order_line do |conf|
	  conf.columns[:price].options = {:format => :currency}
	  conf.columns[:qty].options[:format] = "%2f"
  end
end 
