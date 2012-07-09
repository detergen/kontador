class Order < ActiveRecord::Base
	belongs_to :from, :class_name => "Organization"
	belongs_to :to, :class_name => "Organization"
	belongs_to :recipient, :class_name => "Organization"

	has_many :order_lines

end
