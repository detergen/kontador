class ContactsController < ApplicationController
  active_scaffold :contact do |conf|
	  conf.nested.add_link(:addrs, :label => "Addreses", :page => true)
  end
end 
