require 'rubygems'
require 'nokogiri'
require 'mechanize'
require 'active_record'

agent = Mechanize.new
page = agent.get("https://tw.screener.finance.yahoo.net/future/aa03?fumr=futurepart")
parse_html = Nokogiri::HTML.parse(page.parser.to_html)
close_price_spot = parse_html.xpath("//*[@id='ext-wrap']/table[2]/tbody/tr[1]/td[4]").children.to_s.to_f


puts close_price_spot

