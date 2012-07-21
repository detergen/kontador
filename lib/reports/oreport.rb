# -*- encoding : utf-8 -*-
module Oreport

	include ActionView::Helpers::NumberHelper

		#Return report and filename for send_file in controller
		def self.bill(orderinfo)
			nc = ActionView::Base.new

			#Getting info for "bill from"
			@ohash = orderinfo

			#Creating report
			#TODO create optional user path to templates
			report = ODFReport::Report.new("app/assets/reports/bill.odt") do |r|
				r.add_field :order_number, @ohash["order"].number
				r.add_field :order_document_date, @ohash["order"].document_date.strftime("%d.%m.%Y")

				#Organization from fields
				r.add_field :from, @ohash["from"].short_name
				r.add_field :from_inn, @ohash["from"].inn
				r.add_field :from_kpp, @ohash["from"].kpp
				r.add_field :from_law_address, @ohash["faddress"]

				#Organization "to" fields
				r.add_field :to, @ohash["to"].short_name
				r.add_field :recipient, @ohash["recipient"].short_name

				#Bank acc fields 
				r.add_field :bank_ks, @ohash["bankacc_from"].ks
				r.add_field :bank_rs, @ohash["bankacc_from"].rs
				r.add_field :bank_bik, @ohash["bankacc_from"].bik
				r.add_field :bank_fullname, @ohash["bankacc_from"].full_name


				#Order lines 
				@posnumber = 0 #Initial number for order lines (items)
				r.add_table("TABLE_1", @ohash["orderlines"], :header=>true) do |t|
					t.add_column(:id) {@posnumber +=1}
					t.add_column(:articul) {|order_line| order_line.product.articul}
					t.add_column(:product) {|order_line| order_line.product.name }
					t.add_column (:item_qty) {|order_line| nc.number_with_precision(order_line.qty, :precision => 5, :significant => true, :strip_insignificant_zeros  => true)}
					t.add_column (:price) {|order_line| nc.number_to_currency(order_line.price,:unit => "")}
					t.add_column(:sumprice) {|order_line| nc.number_to_currency(order_line.sum_price,:unit => "")}
					t.add_column(:sku) {|order_line| order_line.product.sku[:name]}
				end

				#Totals and number to words lines
				r.add_field :total, nc.number_to_currency(@ohash["order"].total_price)
				r.add_field :vat_in, nc.number_to_currency((@ohash["order"].total_price)/118.0*18.0) #TODO Make VAT formula as class method or something
				r.add_field :pos_propisju, RuPropisju.propisju_shtuk(@ohash["orderlines"].length, 3, ["наименование","наименования","наименований"])
				r.add_field :total_propisju, RuPropisju.rublej(@ohash["order"].total_price)

				#Signatures 
				r.add_field :sign1, @ohash["sign_1"].short_name
				r.add_field :sign2, @ohash["sign_2"].short_name

			end

			#Creating meaningful file name
			@report=Hash.new
			@report["report"] = report.generate
			@report["file_name"] = "Счет_№" + @ohash["order"].number + "_" + @ohash["from"].name + "-" + @ohash["to"].name + "_" + @ohash["order"].document_date.strftime("%d.%m.%Y") + "_на_" + nc.number_to_currency(@ohash["order"].total_price, :unit => "") + ".odt"

			return @report	
		end

		#Return report and filename for send_file in controller
		def self.warrant(orderinfo)
			nc = ActionView::Base.new

			#Getting info for "bill from"
			@ohash = orderinfo

			#Creating report
			#TODO create optional user path to templates
			report = ODFReport::Report.new("app/assets/reports/warrant.odt") do |r|
				r.add_field :order_number, @ohash["order"].number
				r.add_field :order_document_date, @ohash["order"].document_date.strftime("%d.%m.%Y")

				#Organization from fields
				r.add_field :from, @ohash["from"].short_name
				r.add_field :from_inn, @ohash["from"].inn
				r.add_field :from_kpp, @ohash["from"].kpp
				r.add_field :from_law_address, @ohash["faddress"]

				#Organization "to" fields
				r.add_field :to, @ohash["to"].short_name
				r.add_field :recipient, @ohash["recipient"].short_name

				#Bank acc fields 
				r.add_field :bank_ks, @ohash["bankacc_from"].ks
				r.add_field :bank_rs, @ohash["bankacc_from"].rs
				r.add_field :bank_bik, @ohash["bankacc_from"].bik
				r.add_field :bank_fullname, @ohash["bankacc_from"].full_name

				r.add_field :test, @ohash["warrant"].contact.name

				#Order lines 
				@posnumber = 0 #Initial number for order lines (items)
				r.add_table("TABLE_1", @ohash["orderlines"], :header=>true) do |t|
					t.add_column(:id) {@posnumber +=1}
					t.add_column(:articul) {|order_line| order_line.product.articul}
					t.add_column(:product) {|order_line| order_line.product.name }
					t.add_column (:item_qty) {|order_line| nc.number_with_precision(order_line.qty, :precision => 5, :significant => true, :strip_insignificant_zeros  => true)}
					t.add_column (:item_qty_human) {|order_line| RuPropisju.propisju_shtuk(nc.number_with_precision(order_line.qty, :precision => 5, :significant => true, :strip_insignificant_zeros  => true), 1, [])}
					t.add_column (:price) {|order_line| nc.number_to_currency(order_line.price,:unit => "")}
					t.add_column(:sumprice) {|order_line| nc.number_to_currency(order_line.sum_price,:unit => "")}
					t.add_column(:sku) {|order_line| order_line.product.sku[:name]}
				end

				#Totals and number to words lines
				r.add_field :total, nc.number_to_currency(@ohash["order"].total_price)
				r.add_field :vat_in, nc.number_to_currency((@ohash["order"].total_price)/118.0*18.0) #TODO Make VAT formula as class method or something
				r.add_field :pos_propisju, RuPropisju.propisju_shtuk(@ohash["orderlines"].length, 3, ["наименование","наименования","наименований"])
				r.add_field :total_propisju, RuPropisju.rublej(@ohash["order"].total_price)

				#Warrant owner
				r.add_field :warrant_id, @ohash["warrant"].id
				r.add_field :warrant_date, @ohash["warrant"].date.strftime("%d.%m.%Y")
				r.add_field :warrant_date_till, @ohash["warrant"].date_till.strftime("%d.%m.%Y")
				r.add_field :name, @ohash["warrant"].contact.to_name

				#Warrant owner's passport data
				r.add_field :pasp_series, @ohash["warrant"].contact.pasp_series
				r.add_field :pasp_number, @ohash["warrant"].contact.pasp_number
				r.add_field :pasp_date, @ohash["warrant"].contact.pasp_date
				r.add_field :pasp_given, @ohash["warrant"].contact.pasp_given

				#Signatures 
				r.add_field :sign1, @ohash["sign_1"].short_name
				r.add_field :sign2, @ohash["sign_2"].short_name

			end

			#Creating meaningful file name
			@report=Hash.new
			@report["report"] = report.generate
			@report["file_name"] = "Доверенность_№" + @ohash["warrant"].id.to_s + "_" + @ohash["warrant"].contact.short_name + "-" + @ohash["to"].name + "_до_" + @ohash["warrant"].date_till.strftime("%d.%m.%Y") + "_к сч_" + @ohash["order"].number + ".odt"

			return @report	
		end
end
