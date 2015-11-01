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
		
		
def write_data_volume(input)
    @records = ""
      input.each do |item|
      	puts item
       	@records = "#{@records}"+ item.to_s + ","
      end
      
      puts "\n"
      puts @records
		  File.open('tw_future_volume', 'a') { |file| file.write("#{@records}\n") }
	
		  # write database 
		  
		  puts " writing table volume "
		
     		volume = Futurevolume.new
		    volume.check_date = input[0]
		    volume.commodity_type  = input[1]
		    volume.foreign_unsettle_volume = input[2]
		    volume.total_unsettle_volume = input[3]
		    volume.save
		  
		  puts "write OK"
		  @records = ""
end		
	
def price_quote(input)
	 @records = ""
      input.each do |item|
      	puts item
       	@records = "#{@records}"+ item.to_s + ","
      end
      
      puts "\n"
      puts @records
		  File.open('tw_future_quote', 'a') { |file| file.write("#{@records}\n") }
	
	  @records = "" 
	  
		  # write database 

		  puts " writing table quote "
		
     		quote = Futurequote.new
		    quote.check_date = input[0]
		    quote.commodity_type  = input[1]
		    quote.open_price = input[2]
		    quote.highest_price = input[3]
		    quote.lowest_price = input[4]
		    quote.close_price = input[5]
		    quote.volume = input[6]
		    quote.save
		  
		  puts "write OK"  	
 
end



		page = agent.get("https://tw.screener.finance.yahoo.net/future/aa04?page=future")
		page_html = Nokogiri::HTML.parse(page.parser.to_html)
		
		printdata = []
		
		check_date_raw = page_html.xpath("//*[@id='future-ten-number']/p[1]/em").children.to_s
		check_date_temp = check_date_raw[0,10].split("/") 
		check_date = check_date_temp[0]+"-"+check_date_temp[1]+"-"+check_date_temp[2]
		
	if check_date_temp[2] == Date.today.mday.to_s

	puts "====大台期的外資未平倉量===="		
		printdata << check_date

	    commodity_type = page_html.xpath("//*[@id='future-ten-number']/table[1]/thead/tr[1]/td[2]").children.to_s
	    printdata << commodity_type

	    foreign_unsettle_volume = page_html.xpath("//*[@id='future-ten-number']/table[1]/tbody/tr[1]/td[4]").children.to_s.to_i
	    printdata << foreign_unsettle_volume

		total_unsettle_volume =page_html.xpath("//*[@id='future-ten-number']/table[1]/tbody/tr[4]/td[4]").children.to_s.to_i
		printdata << total_unsettle_volume

		write_data_volume(printdata)
		

	puts "====台股現貨,大台期,小台期,的開高收低===="
	
   		page2 = agent.get("https://tw.screener.finance.yahoo.net/future/aa03?fumr=futurepart")
		page_html2 = Nokogiri::HTML.parse(page2.parser.to_html)

		quotedata =[]
		
		quotedata << check_date
		
		  commodity_type_spot = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[1]/a").children.to_s
		  quotedata << commodity_type_spot
	      open_price_spot = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[8]").children.to_s.to_f
	      quotedata << open_price_spot
	      highest_price_spot = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[9]").children.to_s.to_f
	      quotedata << highest_price_spot
	      lowest_price_spot = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[10]").children.to_s.to_f
	      quotedata << lowest_price_spot
	      close_price_spot = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[4]").children.to_s.to_f
	      quotedata << close_price_spot
	      volume_spot = page_html2.xpath("//*[@id='ext-wrap']/table[1]/tbody/tr/td[8]").children.to_s.to_f
	      quotedata << volume_spot
	      
	      price_quote(quotedata)
	      
	      quotedata.clear
	      quotedata << check_date
	 
		  commodity_type_tx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[1]/a").children.to_s
		  quotedata << commodity_type_tx
	      open_price_tx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[8]").children.to_s.to_f
	      quotedata << open_price_tx
	      highest_price_tx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[9]").children.to_s.to_f
	      quotedata << highest_price_tx
	      lowest_price_tx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[10]").children.to_s.to_f
	      quotedata << lowest_price_tx
	      close_price_tx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[4]").children.to_s.to_f
	      quotedata << close_price_tx
	      volume_tx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[2]/td[13]").children.to_s.to_f
	      quotedata << volume_tx

	      price_quote(quotedata)
	      
	      quotedata.clear
	      quotedata << check_date
	      
		  commodity_type_minitx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[1]/a").children.to_s
		  quotedata << commodity_type_minitx
	      open_price_spot_minitx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[8]").children.to_s.to_f
	      quotedata << open_price_spot_minitx
	      highest_price_spot_minitx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[9]").children.to_s.to_f
	      quotedata << highest_price_spot_minitx
	      lowest_price_spot_minitx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[10]").children.to_s.to_f
	      quotedata << lowest_price_spot_minitx
	      close_price_spot_minitx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[4]").children.to_s.to_f
	      quotedata << close_price_spot_minitx
	      volume_minitx = page_html2.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[11]/td[13]").children.to_s.to_f
	      quotedata << volume_minitx
	      
     	  price_quote(quotedata)
	      
	else
		
		File.open('tw_future_volume', 'a') { |file| file.write("#{Date.today} 未開盤\n") }
		File.open('tw_future_quote', 'a') { |file| file.write("#{Date.today} 未開盤\n") }
	
	end  
 
   
   



