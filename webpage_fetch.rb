		require 'rubygems'
		require 'nokogiri'
		require 'mechanize'
		require 'active_record'

        agent = Mechanize.new
		page = agent.get("http://mp.weixin.qq.com/s?__biz=MjM5ODA0MzE2MA==&mid=400652249&idx=1&sn=d591db64f4e834c333eeddf09e3bf259&scene=5&srcid=1203aiqPfJDCzXXGTVMBzJSY#rd")
		parse_html = Nokogiri::HTML.parse(page.parser.to_html)
     	File.open('webpage_fetch.html', 'a') { |file| file.write("#{parse_html}") }
		
