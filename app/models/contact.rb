class Contact < ActiveRecord::Base
	belongs_to :organization
	has_many :addrs
end
