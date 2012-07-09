class Organization < ActiveRecord::Base
	has_many :bankaccs
	has_many :contacts
	has_many :addrs
	

	#Order associations
	has_many :from, :class_name => "Order", :foreign_key => "from_id"
	has_many :to, :class_name => "Order", :foreign_key => "to_id"
	has_many :recipient, :class_name => "Order", :foreign_key => "recipient_id"

end
