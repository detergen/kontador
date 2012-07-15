class Organization < ActiveRecord::Base
	has_many :bankaccs
	has_many :contacts
	has_many :addrs
	
	#has_many :product_orgs
	#has_many :products, :through => :product_orgs, :readonly => false
end
