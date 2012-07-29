class Bankacc < ActiveRecord::Base
	belongs_to :organization
	has_many :orders
	has_many :payments, :class_name => "Payment", :foreign_key => 'fromacc_id'
	has_many :payments, :class_name => "Payment", :foreign_key => 'toacc_id'

end
