# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController

	include ActionView::Helpers::NumberHelper
	include Oreport
	include Orderinfo

	active_scaffold :order do |conf|

		#conf.create.action_group = 'collection.menu' 
		#conf.search.action_group = 'collection.menu' 

		#conf.show.action_group = 'member.actions.crud' 
		#conf.delete.action_group = 'member.actions.crud' 
		#conf.update.action_group = 'member.actions.crud' 
		#conf.nested.action_group = 'member.actions.nested'

		conf.nested.add_link(:order_lines, :label => "Dive in", :page => true)


		conf.action_links.add 'bill', :label => 'Invoice', :page => true, :type => :member
		conf.action_links.add 'torg12', :label => 'T12', :page => true, :type => :member

		conf.list.columns = [
			:number,
			:document_date,
			:from,
			:to,
			:total_price,
			:tag,
		]

		conf.columns = [
			:from,
			:bankacc,
			:number,
			:document_date,
			:to,
			:recipient,
			:total_price,
			:status,
			:order_date,
			:note,
			:tag,
			:order_lines
		]
			conf.columns[:to].form_ui = :select
			conf.columns[:recipient].form_ui = :select
			conf.columns[:from].form_ui = :select
			conf.columns[:bankacc].form_ui = :select
			conf.columns[:total_price].options = {:format => :currency}

	# Add a copy link 
		end



	#Report - bill
		def bill 
			@ohash = Orderinfo.getall(params[:id])
			@report = Oreport.bill(@ohash)
			send_file(@report["report"], :filename => @report["file_name"]) 
		end

	#Report - Torg12
		def torg12 
			@ohash = Orderinfo.getall(params[:id])
			@report = Oreport.torg12(@ohash)
			send_file(@report["report"], :filename => @report["file_name"]) 
		end
end

# Add the copy action 
