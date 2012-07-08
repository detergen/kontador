class Organization < ActiveRecord::Base
	has_many :bankaccs
	has_many :contacts
	has_many :addrs
end
