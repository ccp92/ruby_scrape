# frozen_string_literal: true

require 'HTTParty'
require 'Nokogiri'

class Scraper
  attr_accessor :parse_page

  def initialize
    doc = HTTParty.get('https://learn.madetech.com/katas/')
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def names
    @parse_page.css('li').css('a').children.map(&:text)
  end

  scraper = Scraper.new
  names = scraper.names

  puts 'Katas:'
  puts '~~~~~~'
  (0...names.size).each { |index| puts names[index].to_s }
end
