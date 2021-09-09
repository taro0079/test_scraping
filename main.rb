require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'
# require 'nokogiri'

class Scraping
  attr_reader :doc, :page, :xpaths

  def initialize(url)
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, {inspector: true, js_errors: false})
    end
    Capybara.javascript_driver = :poltergeist
    @page = Capybara::Session.new(:poltergeist)
    page.driver.headers = {
      'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2564.97 Safari/537.36'
    }
    page.visit(url)

    @xpaths = {
      rent_fee: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[1]/td',
      management_fee: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[2]/td',
      floor: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[3]/td',
      madori: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[4]/td',
      sikikin_and_reikin: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[6]/td',
      tyukai_tesuryo: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[7]/td',
      hosyokin: '/html/body/div[1]/main/article/div[2]/div[2]/table/tbody/tr[8]/td',

    }
  end

  def allpoperties
    {
      rent_fee: rent_fee,
      management_fee: management_fee,
      floor: floor,
      madori: madori,
      sikikin_and_reikin: sikikin_and_reikin,
      tyukai_tesuryo: tyukai_tesuryo,
      hosyokin: hosyokin

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

  def floor
    scraping_data(xpaths[:floor])
  end

  def madori
    scraping_data(xpaths[:madori])
  end

  def sikikin_and_reikin
    scraping_data(xpaths[:sikikin_and_reikin])
  end

  def tyukai_tesuryo
    scraping_data(xpaths[:tyukai_tesuryo])
  end

  def hosyokin
    scraping_data(xpaths[:hosyokin])
  end
end

sc = Scraping.new('https://www.goodrooms.jp/tokyo/detail/001/5240702/?transit_area=216%27')
p sc.allpoperties
