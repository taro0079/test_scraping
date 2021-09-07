require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
require 'nokogiri'

class Scraping
  include Capybara::DSL
  attr_reader :doc, :page, :xpaths


  def initialize(url)
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, :inspector => true )
    end
    Capybara.default_driver = :poltergeist
    Capybara.javascript_driver = :poltergeist
    # Capybara.default_selector = :xpath
    @page = Capybara::Session.new(:poltergeist)
    page.visit(url)

    @xpaths = {
      rent_fee: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[1]/td',
      management_fee: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[2]/td',
    }

  end


  def allpoperties
    {
      rent_fee: rent_fee,
      management_fee: management_fee
    }
  end
  private
  def scraping_data(target)
    page.find(:xpath, target).text
  end

  def rent_fee
    scraping_data(xpaths[:rent_fee])
  end

  def management_fee
    scraping_data(xpaths[:management_fee])
  end


end

sc = Scraping.new('https://www.goodrooms.jp/tokyo/detail/001/5240702/?transit_area=216')
p sc.allpoperties