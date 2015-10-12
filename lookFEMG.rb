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

class Consult < ActiveRecord::Base

end		
		
		
def print_data(page_html)
	  patient_numbers_string = page_html.xpath("//*[@id=\"ctl00_FunctionContent_ctl00_Label2\"]").children.children.to_s.strip
	  check_date = page_html.xpath("//*[@id=\"ctl00_FunctionContent_ctl00_Label3\"]").children.to_s.strip
 	  check_type = page_html.xpath("//*[@id=\"ctl00_FunctionContent_ctl00_Label4\"]").children.to_s.strip
	  doc_name = page_html.xpath("//*[@id=\"ctl00_FunctionContent_ctl00_Label5\"]").children.to_s.strip
	  time_slot = page_html.xpath("//*[@id=\"ctl00_FunctionContent_ctl00_Label6\"]").children.to_s.strip
	  room_no = page_html.xpath("//*[@id=\"ctl00_FunctionContent_ctl00_Label7\"]").children.to_s.strip
	  
	  patient_numbers_only = patient_numbers_string.scan(/\d+/).first
	  
	  #puts "==== #{time_slot} ====="
	  puts check_date
	  puts check_type
	  puts doc_name
	  puts patient_numbers_string
	  puts patient_numbers_only
	  puts time_slot
	  puts room_no
	  
	  
	  
	  records = "#{check_date},#{check_type},#{doc_name},#{patient_numbers_string},#{patient_numbers_only},#{time_slot},#{room_no}\n"
	  if records != ",,,,,,\n"
	  File.open('look_result_October', 'a') { |file| file.write("#{records}") }

	  check_date_temp = check_date.split("/") 
	  check_date1 = check_date_temp[0]+"-"+check_date_temp[1]+"-"+check_date_temp[2]

	  
	  # write database 
	  
	  puts " writing database "
		consult = Consult.new
	    consult.check_date1 = check_date1
	    consult.check_date2 = check_date
	    consult.check_type  = check_type
	    consult.doc_name = doc_name
	    consult.patient_no_string = patient_numbers_string
	    consult.patient_no_only = patient_numbers_only
	    consult.time_slot = time_slot
	    consult.room_no = room_no
	    consult.save
	  
	  puts "write OK"  
	    
	  end
	  
	  
	  
	  
end		
	
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

	
	
=begin		
		
		#心臟內科
		cv_room = ["F101", "F102", "F103", "F104", "F105", "F106", "F112"] 
		#新陳代謝科
		meta_room = ["G222" , "G223", "G224", "G234"]
		#腎臟科
		kn_room = ["G232", "G233", "H123", "2012"]
		#家醫科
		fm_room = ["F107", "F108", "F109", "F111"]
		#神經內科
		neuro_room = ["F201", "F202", "F203", "F204", "G234"] 
		
		year_month = "10409"
	    month_day = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]
		lookup_date = []
		
		month_day.each do |day|
		  lookup_date << year_month+day  
		end
		
		#puts "==date====="
		#puts lookup_date

  		
		puts "=====lookup_result====="
=end		
		
    today_date = "104"+Date.today.strftime("%m%d")
  # today_date = "1041008"
     
	puts "====CV上午診===="
	get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0401&SecName=%E5%BF%83%E8%87%9F%E8%A1%80%E7%AE%A1%E5%85%A7%E7%A7%91&chOp0Time=1")
	@cv_room.each do |room|
		page = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=1&secno=0401&chop0clmdocid=83095&chregdate=#{today_date}&chregroom=#{room}")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
        print_data(parse_html)
    end 

    puts "====CV下午診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0401&SecName=%E5%BF%83%E8%87%9F%E8%A1%80%E7%AE%A1%E5%85%A7%E7%A7%91&chOp0Time=2")
    @cv_room.each do |room|
		page2 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=2&secno=0401&chop0clmdocid=67116&chregdate=#{today_date}&chregroom=#{room}")
		parse_html2 = Nokogiri::HTML.parse(page2.parser.to_html)
	    print_data(parse_html2)
    end 
    
    puts "====CV晚上診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0401&SecName=%E5%BF%83%E8%87%9F%E8%A1%80%E7%AE%A1%E5%85%A7%E7%A7%91&chOp0Time=3")
    @cv_room.each do |room|
		page3 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=3&secno=0401&chop0clmdocid=89754&chregdate=#{today_date}&chregroom=#{room}")
		parse_html3 = Nokogiri::HTML.parse(page3.parser.to_html)
	    print_data(parse_html3)
    end     


#cs 

	puts "====CS上午診===="
	get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0406&SecName=%E5%BF%83%E8%87%9F%E8%A1%80%E7%AE%A1%E5%A4%96%E7%A7%91&chOp0Time=1")
	@cv_room.each do |room|
		page = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=1&secno=0406&chop0clmdocid=92013&chregdate=#{today_date}&chregroom=#{room}")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
        print_data(parse_html)
    end 

    puts "====CS下午診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0406&SecName=%E5%BF%83%E8%87%9F%E8%A1%80%E7%AE%A1%E5%A4%96%E7%A7%91&chOp0Time=2")
    @cv_room.each do |room|
		page2 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=2&secno=0406&chop0clmdocid=87919&chregdate=#{today_date}&chregroom=#{room}")
		parse_html2 = Nokogiri::HTML.parse(page2.parser.to_html)
	    print_data(parse_html2)
    end 
    
    puts "====CS晚上診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0406&SecName=%E5%BF%83%E8%87%9F%E8%A1%80%E7%AE%A1%E5%A4%96%E7%A7%91&chOp0Time=3")
    @cv_room.each do |room|
		page3 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=3&secno=0406&chop0clmdocid=87919&chregdate=#{today_date}&chregroom=#{room}")
		parse_html3 = Nokogiri::HTML.parse(page3.parser.to_html)
	    print_data(parse_html3)
    end     

  

#meta 
    
	puts "====Meta 上午診===="
	get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0203&SecName=%E6%96%B0%E9%99%B3%E4%BB%A3%E8%AC%9D%E7%A7%91&chOp0Time=1")
	@cv_room.each do |room|
		page = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=1&secno=0203&chop0clmdocid=42522&chregdate=#{today_date}&chregroom=#{room}")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
        print_data(parse_html)
    end 

    puts "====Meta 下午診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0203&SecName=%E6%96%B0%E9%99%B3%E4%BB%A3%E8%AC%9D%E7%A7%91&chOp0Time=2")
    @cv_room.each do |room|
		page2 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=2&secno=0203&chop0clmdocid=61003&chregdate=#{today_date}&chregroom=#{room}")
		parse_html2 = Nokogiri::HTML.parse(page2.parser.to_html)
	    print_data(parse_html2)
    end 
    
    puts "====Meta 晚上診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0203&SecName=%E6%96%B0%E9%99%B3%E4%BB%A3%E8%AC%9D%E7%A7%91&chOp0Time=3")
    @cv_room.each do |room|
		page3 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=3&secno=0203&chop0clmdocid=54570&chregdate=#{today_date}&chregroom=#{room}")
		parse_html3 = Nokogiri::HTML.parse(page3.parser.to_html)
	    print_data(parse_html3)
    end     
  

#neuro 

	puts "====Neuro 上午診===="
	get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0206&SecName=%E7%A5%9E%E7%B6%93%E5%85%A7%E7%A7%91&chOp0Time=1")
	@cv_room.each do |room|
		page = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=1&secno=0206&chop0clmdocid=00627&chregdate=#{today_date}&chregroom=#{room}")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
        print_data(parse_html)
    end 

    puts "====Neuro 下午診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0206&SecName=%E7%A5%9E%E7%B6%93%E5%85%A7%E7%A7%91&chOp0Time=2")
    @cv_room.each do |room|
		page2 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=2&secno=0206&chop0clmdocid=89828&chregdate=#{today_date}&chregroom=#{room}")
		parse_html2 = Nokogiri::HTML.parse(page2.parser.to_html)
	    print_data(parse_html2)
    end 
    
    puts "====Neuro 晚上診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0206&SecName=%E7%A5%9E%E7%B6%93%E5%85%A7%E7%A7%91&chOp0Time=3")
    @cv_room.each do |room|
		page3 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=3&secno=0206&chop0clmdocid=89828&chregdate=#{today_date}&chregroom=#{room}")
		parse_html3 = Nokogiri::HTML.parse(page3.parser.to_html)
	    print_data(parse_html3)
    end     
 
#Family Hospital 

	puts "====Family 上午診===="
	get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0292&SecName=%E5%AE%B6%E5%BA%AD%E9%86%AB%E5%AD%B8%E7%A7%91&chOp0Time=1")
	@cv_room.each do |room|
		page = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=1&secno=0292&chop0clmdocid=89827&chregdate=#{today_date}&chregroom=#{room}")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
        print_data(parse_html)
    end 

    puts "====Family 下午診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0292&SecName=%E5%AE%B6%E5%BA%AD%E9%86%AB%E5%AD%B8%E7%A7%91&chOp0Time=2")
    @cv_room.each do |room|
		page2 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=2&secno=0292&chop0clmdocid=91241&chregdate=#{today_date}&chregroom=#{room}")
		parse_html2 = Nokogiri::HTML.parse(page2.parser.to_html)
	    print_data(parse_html2)
    end 
    
    puts "====Family 晚上診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0292&SecName=%E5%AE%B6%E5%BA%AD%E9%86%AB%E5%AD%B8%E7%A7%91&chOp0Time=3")
    @cv_room.each do |room|
		page3 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=3&secno=0292&chop0clmdocid=90431&chregdate=#{today_date}&chregroom=#{room}")
		parse_html3 = Nokogiri::HTML.parse(page3.parser.to_html)
	    print_data(parse_html3)
    end     
 
#Nephrology

	puts "====Nephrology 上午診===="
	get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0205&SecName=%E8%85%8E%E8%87%9F%E5%85%A7%E7%A7%91&chOp0Time=1")
	@cv_room.each do |room|
		page = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=1&secno=0205&chop0clmdocid=61636&chregdate=#{today_date}&chregroom=#{room}")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
        print_data(parse_html)
    end 

    puts "====Nephrology 下午診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0205&SecName=%E8%85%8E%E8%87%9F%E5%85%A7%E7%A7%91&chOp0Time=2")
    @cv_room.each do |room|
		page2 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=2&secno=0205&chop0clmdocid=61636&chregdate=#{today_date}&chregroom=#{room}")
		parse_html2 = Nokogiri::HTML.parse(page2.parser.to_html)
	    print_data(parse_html2)
    end 
    
    puts "====Nephrology 晚上診===="
    get_room("http://www.femh.org.tw/visit/visit.aspx?Action=9_1&MenuType=0&secno=0205&SecName=%E8%85%8E%E8%87%9F%E5%85%A7%E7%A7%91&chOp0Time=3")
    @cv_room.each do |room|
		page3 = agent.get("http://www.femh.org.tw/visit/visit.aspx?Action=9_2&MenuType=0&chOp0Time=3&secno=0205&chop0clmdocid=89745&chregdate=#{today_date}&chregroom=#{room}")
		parse_html3 = Nokogiri::HTML.parse(page3.parser.to_html)
	    print_data(parse_html3)
    end     

