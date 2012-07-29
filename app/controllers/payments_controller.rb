# -*- encoding : utf-8 -*-
class PaymentsController < ApplicationController
	active_scaffold :payment do |conf|
		conf.list.columns = [
			:pay_date,
			:note,
			:tag,
			:status,
			:amount,
		]
		conf.columns[:amount].calculate = :sum

		conf.action_links.add 'import1c', :label => 'Import 1c', :page => true, :type => :collection
		#conf.action_links.add 'import1c', :label => 'Import 1c', :page => true, :type => :member
	end

	#import data from 1c
	def import1c
		out_file = File.open('k.csv', 'w')

		IO.foreach('k.txt') do |line|

			if line =~ /^СекцияДокумент=Платежное поручение$/
				out_file.puts line.chomp
			end

			#if line =~ /^-+$/
			#out_file.puts the_line.join(',')
			#the_line = []
			#elsif line =~ /^Title$/
			#in_title = true
			#elsif line =~ /^(?:Publishe(?:r|d Date)|Number\d|Category):\s+(.*?)$/
			#the_line += [$1]
			#in_title = false
			#elsif in_title
			#the_line[0] = (the_line.empty? ?  line.chomp : "\"#{the_line[0]} #{line.chomp}\"")
			#else
			#puts "Error: don't know what to do with line #{line}"
			#end
		end
		out_file.close

	end

end 
