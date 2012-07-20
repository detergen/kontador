class Warrant < ActiveRecord::Base
	belongs_to :order
	belongs_to :contact
end
