class OrganizationsController < ApplicationController
  active_scaffold :organization do |conf|
	  conf.nested.add_link(:bankaccs, :label => "Bank accounts", :page => true)
	  conf.nested.add_link(:addrs, :label => "Addreses", :page => true)
	  conf.nested.add_link(:contacts, :label => "Contacts", :page => true)
	  #conf.nested.add_link(:products, :label => "Products", :page => true)
  end
end 
