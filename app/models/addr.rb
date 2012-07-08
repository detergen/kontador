class Addr < ActiveRecord::Base
	belongs_to :organization
	belongs_to :contact
end
