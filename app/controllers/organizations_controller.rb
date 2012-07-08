class OrganizationsController < ApplicationController
  active_scaffold :organization do |conf|
	  conf.nested.add_link(:bankaccs, :label => "Bank accounts", :page => true)
	  conf.nested.add_link(:addrs, :label => "Addreses", :page => true)
	  conf.nested.add_link(:contacts, :label => "Contacts", :page => true)
	  #config.nested.add_link(:bankaccs)
	  #config.nested.add_link "Bank Accounts", [:bankaccs]
	  #config.nested.shallow_delete = true 
	  #config.list.columns.exclude :bikerels
	  #config.columns[:bankaccs].form_ui = :select
  end
end 
