class WarrantsController < ApplicationController
  active_scaffold :warrant do |conf|
	  conf.columns[:order].form_ui = :select
	  conf.columns[:contact].form_ui = :select
  end
end 
