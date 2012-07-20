module Orderinfo
	include ActionView::Helpers::NumberHelper

	#Return all related data for order with orderid
	def self.getall(orderid)

		@order = Order.find(orderid, :include => {:from => :addrs}, :conditions => {:from => {:addrs => {:key => "law_address"}}})

		#Creating hash for all order related data
		@ohash = Hash.new 

		@ohash["order"] = @order
		@ohash["from"] =  @order.from
		@ohash["to"] =  @order.to
		@ohash["recipient"] =  @order.recipient
		@ohash["faddress"] = @order.from.addrs[0] #Getting 1 related address for law address field
		@ohash["bankacc_from"] = @order.bankacc #Getting bank account info
		@ohash["sign_1"] = Order.includes(:from => :contacts).where(:from => {:contacts => {:key => "head"}}).find(orderid).from.contacts[0]
		@ohash["sign_2"] = Order.includes(:from => :contacts).where(:from => {:contacts => {:key => "book"}}).find(orderid).from.contacts[0]
		@ohash["orderlines"] = OrderLine.find(:all, :conditions => ['order_id = ?', orderid ], :joins => [:product])

		#Formating string to readable
		@ohash["order"].document_date = @ohash["order"].document_date.strftime("%d.%m.%Y")


		#Create short org name with prefix
		@ohash["from"].short_name = "#{@order.from.opf} \"#{@order.from.short_name}\""
		@ohash["to"].short_name = "#{@order.to.opf} \"#{@order.to.short_name}\""
		@ohash["recipient"].short_name = "#{@order.recipient.opf} \"#{@order.recipient.short_name}\""

		#Create addres with postindex TODO include second addres string
		@ohash["faddress"] = "#{@order.from.addrs[0].postindex} #{@order.from.addrs[0].string1}"

		return @ohash
	end

end
