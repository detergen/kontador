class Contact < ActiveRecord::Base
	belongs_to :organization
	has_many :addrs
	has_many :warrants
end
