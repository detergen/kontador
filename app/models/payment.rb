class Payment < ActiveRecord::Base
	belongs_to :order

	belongs_to :fromacc, :class_name => "Bankacc", :foreign_key => 'fromacc_id'
	belongs_to :toacc, :class_name => "Bankacc", :foreign_key => 'toacc_id'


end
