		require 'rubygems'
		require 'nokogiri'
		require 'mechanize'
		require 'active_record'

		agent = Mechanize.new

ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'w'))
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'db/development.sqlite3'
)

class Futurevolume < ActiveRecord::Base
end		
	
class Futurequote < ActiveRecord::Base
end		
		
		
def write_data(input,type)

      input.each do |item|
      	puts item
       	@records = "#{@records}"+ item.to_s + ","
      end
      
      puts "\n"
      puts @records
	

#	  records = "#{check_date1},#{commodity_type},#{total_unsettle_volume},#{foreign_unsettle_volume}\n"
#	  if records != ",,,,,,\n"
#		  File.open('tw_futre_volume', 'a') { |file| file.write("#{records}") }
	
		  # write database 
		  
#		  puts " writing database "
		

     		volume = Futurevolume.new
#		    volume.check_date1 = check_date1
#		    volume.commodity_type  = commodity_type
#		    volume.total_unsettle_volume = total_unsettle_volume
#		    volume.foreign_unsettle_volume = foreign_unsettle_volume
#		    volume.save
		  
#		  puts "write OK"  
#	  end   #if end

end		
	
def price_quote(page_html)
	
	  commodity_type_spot = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[1]/a").children.to_s
      open_price_spot = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[8]").children.to_s.to_f
      highest_price_spot = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[9]").children.to_s.to_f
      lowest_price_spot = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[10]").children.to_s.to_f
      close_price_spot = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[4]").children.to_s.to_f
      volume_spot = page_html.xpath("//*[@id='ext-wrap']/table[1]/tbody/tr/td[8]").children.to_s.to_f
 
	  commodity_type_tx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[1]/a").children.to_s
      open_price_tx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[8]").children.to_s.to_f
      highest_price_tx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[9]").children.to_s.to_f
      lowest_price_tx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[10]").children.to_s.to_f
      close_price_tx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[4]").children.to_s.to_f
      volume_tx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[13]").children.to_s.to_f

	  commodity_type_minitx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[1]/a").children.to_s
      open_price_spot_minitx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[8]").children.to_s.to_f
      highest_price_spot_minitx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[9]").children.to_s.to_f
      lowest_price_spot_minitx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[10]").children.to_s.to_f
      close_price_spot_minitx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[4]").children.to_s.to_f
      volume_minitx = page_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[13]").children.to_s.to_f
      


	  records = "#{check_date1},#{commodity_type},#{total_unsettle_volume},#{foreign_unsettle_volume}\n"
#	  if records != ",,,,,,\n"
		  File.open('tw_futre_volume', 'a') { |file| file.write("#{records}") }
	
		  # write database 
		  
		  puts " writing database "
			quote = Futurequote.new
		    quote.check_date1 = check_date1
		    quote.commodity_type  = commodity_type
		    quote.total_unsettle_volume = total_unsettle_volume
		    quote.foreign_unsettle_volume = foreign_unsettle_volume
		    consult.save
		  
		  puts "write OK"  
#	  end   #if end
end


	

    
	  	
	

=begin	
	
def get_room(lookup_department_url)
	
	@cv_room = []
	
      agentB = Mechanize.new
      pageB = agentB.get("#{lookup_department_url}")
	  
	  pageB = pageB.links.map! {|x| x.href}
	  
	  pageB.each do |link|
	    if link =~ /visit\.aspx\?Action=9_2&MenuType/
	      @cv_room << link.byteslice(-4..-1)
	    end
	  end
	
end

		year_month = "10409"
	    month_day = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
		lookup_date = []
		
		month_day.each do |day|
		  lookup_date << year_month+day  
		end
		
		#puts "==date====="
		#puts lookup_date

		puts "=====lookup_result====="
		
		
    today_date = "104"+Date.today.strftime("%m%d")
  # today_date = "1041008"
=end


	puts "====大台期的開高收低===="
		page = agent.get("https://tw.screener.finance.yahoo.net/future/aa04?page=future")
		page_html = Nokogiri::HTML.parse(page.parser.to_html)
		
		printdata = []
		
		check_date_raw = page_html.xpath("//*[@id='future-ten-number']/p[1]/em").children.to_s
		check_date_temp = check_date_raw[0,10].split("/") 
		check_date1 = check_date_temp[0]+"-"+check_date_temp[1]+"-"+check_date_temp[2]
		printdata << check_date1

	    commodity_type = page_html.xpath("//*[@id='future-ten-number']/table[1]/thead/tr[1]/td[2]").children.to_s
	    printdata << commodity_type

	    foreign_unsettle_volume = page_html.xpath("//*[@id='future-ten-number']/table[1]/tbody/tr[1]/td[4]").children.to_s.to_i
	    printdata << foreign_unsettle_volume

		total_unsettle_volume =page_html.xpath("//*[@id='future-ten-number']/table[1]/tbody/tr[4]/td[4]").children.to_s.to_i
		printdata << total_unsettle_volume

		type = "volume"

		write_data(printdata, type)
		
		
		

# 




		

	 
 
 
   
   
 #  		page2 = agent.get("https://tw.screener.finance.yahoo.net/future/aa03?fumr=futurepart")
 #  		parse_html2 = Nokogiri::HTML.parse(page.parser.to_html)
 #       price_quote(parse_html2)



