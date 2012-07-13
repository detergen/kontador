class Order < ActiveRecord::Base
	belongs_to :from, :class_name => "Organization"
	belongs_to :to, :class_name => "Organization"
	belongs_to :recipient, :class_name => "Organization"
	belongs_to :bankacc

	has_many :order_lines

	def to_label
		" #: #{number}"
	end

end
