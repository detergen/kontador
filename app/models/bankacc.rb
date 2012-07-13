class Bankacc < ActiveRecord::Base
	belongs_to :organization
	has_many :orders
end
