class WarrantsController < ApplicationController
	include Oreport
	include Orderinfo
	active_scaffold :warrant do |conf|
		conf.columns[:order].form_ui = :select
		conf.columns[:contact].form_ui = :select

		conf.action_links.add 'warrant', :label => 'Warrant', :page => true, :type => :member
	end

	#Report - warrant
	def warrant 
		@ohash = Orderinfo.getwarrant(params[:id])
		@ohash["template"] = "app/assets/reports/warrant.odt"
		@report = Oreport.warrant(@ohash)
		send_file(@report["report"], :filename => @report["file_name"]) 
	end

end 
