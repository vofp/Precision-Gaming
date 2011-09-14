require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "http://www.sc2ranks.com/us/2321412/CypherX"
doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
doc.css(".leagues .shadow").each do |item|
  puts item.at_css(".headertext").text
	item.css(".divisionrank").each do |rank|
		number = rank.at_css(".number").text
		division = rank.at_css("a").text
		puts "Rank #{number} of #{division}"
	end
	#puts item.at_css(".`ListItemLink").text
  #price = item.at_css(".camelPrice").text[/\$[0-9\.]+/]
  #puts "#{title} - #{price}"
  #puts item.at_css(".ListItemLink")[:href]
end
