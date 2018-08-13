# frozen_string_literal: true

require 'HTTParty'
require 'Nokogiri'

class Scraper
  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get('https://www.bbc.co.uk/news')
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def names
    @parse_page.css('h3').children.map(&:text)
  end

  scraper = Scraper.new
  names = scraper.names

  puts 'Headlines:'
  puts '~~~~~~~~~~'
  (0...names.size).each { |index| puts "#{index}: #{names[index]}" }
end
