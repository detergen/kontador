class PaymentsController < ApplicationController
  active_scaffold :payment do |conf|
		conf.list.columns = [
			:pay_date,
			:note,
			:tag,
			:status,
			:amount,
		]
	  conf.columns[:amount].calculate = :sum
  end
end 
