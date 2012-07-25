module Orderinfo
	include ActionView::Helpers::NumberHelper

	#Return all related data for order with order_id
	def self.getall(order_id)

		@order = Order.find(order_id, :include => {:from => :addrs}, :conditions => {:from => {:addrs => {:key => "law_address"}}})

		#Creating hash for all order related data
		@ohash = Hash.new 

		@ohash["order"] = @order
		@ohash["from"] =  @order.from
		@ohash["to"] =  @order.to
		@ohash["recipient"] =  @order.recipient
		@ohash["faddress"] = @order.from.addrs[0] #Getting 1 related address for law address field
		@ohash["taddress"] = @order.to.addrs[0] #Getting 1 related address for law address field
		@ohash["bankacc_from"] = @order.bankacc #Getting bank account info
		@ohash["bankacc_to"] = Bankacc.find(:all, :conditions => ['organization_id = ?', @order.from.id ])
		@ohash["sign_1"] = Order.includes(:from => :contacts).where(:from => {:contacts => {:key => "head"}}).find(order_id).from.contacts[0]
		@ohash["sign_2"] = Order.includes(:from => :contacts).where(:from => {:contacts => {:key => "book"}}).find(order_id).from.contacts[0]
		@ohash["orderlines"] = OrderLine.find(:all, :conditions => ['order_id = ?', order_id ], :joins => [:product])

		#Formating string to readable
		@ohash["order"].document_date = @ohash["order"].document_date.strftime("%d.%m.%Y")


		#Create short org name with prefix
		@ohash["from"].short_name = "#{@order.from.opf} \"#{@order.from.short_name}\""
		@ohash["to"].short_name = "#{@order.to.opf} \"#{@order.to.short_name}\""
		@ohash["recipient"].short_name = "#{@order.recipient.opf} \"#{@order.recipient.short_name}\""

		#Create address with postindex TODO include second addres string
		@ohash["faddress"] = "#{@order.from.addrs[0].postindex} #{@order.from.addrs[0].string1}"
		@ohash["taddress"] = "#{@order.to.addrs[0].postindex} #{@order.to.addrs[0].string1}"

		#TODO decide where Warrant to call from 
		@ohash["warrant"] = Warrant.all( :include => :contact, :conditions => ['order_id = ?', order_id ])[0]


		return @ohash
	end

	#Find order_id for warrant
	def self.getwarrant(warrant_id)
		getall(Warrant.find(warrant_id).order_id)
	end

end
