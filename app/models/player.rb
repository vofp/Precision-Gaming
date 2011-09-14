class Player < ActiveRecord::Base
  has_many :game_wins, :class_name => "Cast", :foreign_key => "winner_id"
  has_many :game_loses, :class_name => "Cast", :foreign_key => "loser_id"
  def games
    game_wins + game_loses
  end
  def rankings
    if sc2ranks_link.blank?
      return ""
    end
    require 'nokogiri'
    require 'open-uri'
    text = ""
    url = sc2ranks_link
    doc = Nokogiri::HTML(open(url))
    doc.css(".leagues .shadow").each do |item|
      text += item.at_css(".headertext").text+"\n"
      a = {}
      item.css(".divisionrank").each do |rank|
        number = rank.at_css(".number").text
        division = rank.at_css("a").text
        a[number] = division
      end
      i = 0
      a.keys.sort.each {|number|
        text += "Rank #{number} of #{a[number]}\n" if 3 > i
        i+=1
      }
    end
    text
  end
end
