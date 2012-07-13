# -*- encoding : utf-8 -*-
class OrdersController < ApplicationController
	include ActionView::Helpers::NumberHelper

	active_scaffold :order do |conf|
			conf.action_links.add 'to_odt', :label => 'Invoice', :page => true, :type => :member
			conf.columns[:from].form_ui = :select
			conf.columns[:to].form_ui = :select
			conf.columns[:recipient].form_ui = :select
			conf.columns[:bankacc].form_ui = :select
		end

		def to_odt

			@order = Order.find(params[:id], :include => {:from => :addrs}, :conditions => {:from => {:addrs => {:key => "law_address"}}})
			@faddress = @order.from.addrs[0]
			@bankacc_from = @order.bankacc
			@orderlines = @order.order_lines
			

			@org_to = @order.to
			@org_recipient = @order.recipient


			#report = ODFReport::Report.new("#{RAILS_ROOT}/app/assets/reports/t.odt") do |r|
			report = ODFReport::Report.new("/home/alex/devel/kontador/app/assets/reports/t.odt") do |r|
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
				#r.add_field :test, @orderlines

				#Order lines 
				r.add_table("TABLE_1", @orderlines, :header=>true) do |t|
					t.add_column(:item_id, :id)
					t.add_column(:articul) {|order_line| order_line.product.articul}	
					t.add_column(:product) {|order_line| order_line.product.name }	
					t.add_column(:item_qty, :qty)
					t.add_column(:price, :price)
					t.add_column(:sumprice, :sum_price)
					t.add_column(:sku) {|order_line| order_line.product.sku[:name]}	
				end

				#Totals and number to words lines
				r.add_field :total, number_to_currency(@orderlines.sum('price*qty'), :locale => :fr)
				r.add_field :vat_in, @orderlines.sum('price*qty/118*18')
				r.add_field :pos_propisju, RuPropisju.propisju_shtuk(@orderlines.count('qty'), 3, ["наименование","наименования","наименований"])
				r.add_field :total_propisju, RuPropisju.rublej(@orderlines.sum('price*qty'))

			end

			report_file_name = report.generate
			send_file(report_file_name)

		end

end 
