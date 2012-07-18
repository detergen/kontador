# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
	include ActionView::Helpers::NumberHelper

	active_scaffold :order do |conf|
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
			:status,
			:order_date,
			:note,
			:tag,
			:order_lines
		]
			conf.action_links.add 'to_odt', :label => 'Invoice', :page => true, :type => :member

			conf.columns[:to].form_ui = :select

			conf.columns[:recipient].form_ui = :select
			conf.columns[:from].form_ui = :select
			conf.columns[:bankacc].form_ui = :select
			conf.columns[:total_price].options = {:format => :currency}
		end


	#Report - bill
		def to_odt
			#Getting info for "bill from"
			@order = Order.find(params[:id], :include => {:from => :addrs}, :conditions => {:from => {:addrs => {:key => "law_address"}}})
			@faddress = @order.from.addrs[0] #Getting 1 related address for law address field
			@bankacc_from = @order.bankacc #Getting bank account info


			#Getting fio for signature TODO make "head" and "book" from some config
			@sign_1 = Order.includes(:from => :contacts).where(:from => {:contacts => {:key => "head"}}).find(params[:id]).from.contacts[0]
			@sign_2 = Order.includes(:from => :contacts).where(:from => {:contacts => {:key => "book"}}).find(params[:id]).from.contacts[0]

			#Getting order lines (items)
			@orderlines = @order.order_lines
			
			#Getting "to" and "recipient info
			@org_to = @order.to
			@org_recipient = @order.recipient
			@posnumber = 0 #Initial number for order lines (items)

			#Creating report
			#TODO create optional user path to templates
			report = ODFReport::Report.new("app/assets/reports/bill.odt") do |r|
				r.add_field :order_number, @order.number
				r.add_field :order_document_date, @order.document_date.strftime("%d.%m.%Y")

				#Organization from fields
				r.add_field :from, "#{@order.from.opf} \"#{@order.from.short_name}\""
				r.add_field :from_inn, @order.from.inn
				r.add_field :from_kpp, @order.from.kpp
				r.add_field :from_law_address, "#{@faddress[:postindex]} #{@faddress[:string1]}"

				#Organization "to" fields
				r.add_field :to, "#{@org_to.opf} \"#{@org_to.short_name}\""
				r.add_field :recipient, "#{@org_recipient.opf} \"#{@org_recipient.short_name}\""

				#Bank acc fields 
				r.add_field :bank_ks, @bankacc_from.ks
				r.add_field :bank_rs, @bankacc_from.rs
				r.add_field :bank_bik, @bankacc_from.bik
				r.add_field :bank_fullname, @bankacc_from.full_name

				#Order lines 
				r.add_table("TABLE_1", @orderlines, :header=>true) do |t|
					t.add_column(:id) {@posnumber +=1} 
					t.add_column(:articul) {|order_line| order_line.product.articul}	
					t.add_column(:product) {|order_line| order_line.product.name }	
					t.add_column(:item_qty, :qty)		
					t.add_column(:price, :price) 		#TODO number to currency 
					t.add_column(:sumprice, :sum_price) #TODO number to currency 
					t.add_column(:sku) {|order_line| order_line.product.sku[:name]}	
				end

				#Totals and number to words lines
				r.add_field :total, number_to_currency(@order.total_price)
                r.add_field :vat_in, number_to_currency(@orderlines.sum('price*qty/118*18'))
				r.add_field :pos_propisju, RuPropisju.propisju_shtuk(@orderlines.count('qty'), 3, ["наименование","наименования","наименований"])
				r.add_field :total_propisju, RuPropisju.rublej(@orderlines.sum('price*qty'))

				#Signatures 
				r.add_field :sign1, @sign_1[:short_name]
				r.add_field :sign2, @sign_2[:short_name]

			end

			report_file_name = report.generate
			send_file(report_file_name)

		end

end 
