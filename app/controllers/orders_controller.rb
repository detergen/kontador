class OrdersController < ApplicationController
	active_scaffold :order do |conf|
			conf.action_links.add 'to_odt', :label => 'Invoice', :page => true, :type => :member, :parameters => {:format => 'pdf'}
			#conf.action_links.add 'to_odt', :label => 'To PDF'
		end

		def to_odt

			@order = Order.find(params[:id])
			@org_from = @order.from
			@org_to = @order.to
			@org_recipient = @order.recipient


			#report = ODFReport::Report.new("#{RAILS_ROOT}/app/assets/reports/t.odt") do |r|
			report = ODFReport::Report.new("/home/alex/devel/kontador/app/assets/reports/t.odt") do |r|
				r.add_field :order_number, @order.number
				r.add_field :order_document_date, @order.document_date.strftime("%d.%m.%Y")
				r.add_field :from, "#{@org_from.opf} \"#{@org_from.short_name}\""
				r.add_field :to, "#{@org_to.opf} \"#{@org_to.short_name}\""
				r.add_field :recipient, "#{@org_recipient.opf} \"#{@org_recipient.short_name}\""

			end

			report_file_name = report.generate

			send_file(report_file_name)


		end

end 
