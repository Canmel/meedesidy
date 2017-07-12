class WetherUtil
  require 'open-uri'
  require 'open_uri_redirections'
  attr_accessor :jsons
  attr_accessor :image_code

  def initialize
    f = open('https://free-api.heweather.com/v5/now?city=CN101210101&key=b6bc7856a16f4361a5440cb26cbf75a3', :allow_redirections => :safe)
    @jsons = JSON.parse(f.gets)
  end

  def images_info
    case cond_code
      when "100"
        return 'fa-sun-o'
      when "101", "102", "103", "104"
        return 'fa-cloud'
      when cond_code =~ /^20./
        return 'wind'
      when cond_code =~ /^30./
        return 'rain'
      when cond_code =~ /^40./
        return 'snow'
      when '500', '501'
        return '雾'
      when '502'
        return '霾'
      when '503'
        return '扬沙'
      when '504', '507', '508'
        return '沙尘暴'
      when '999'
        return '未知'
    end
  end

  def temperature
    jsons["HeWeather5"][0]['now']['tmp']
  end

  def cond_code
    jsons["HeWeather5"][0]['now']['cond']['code']
  end

  def humidity
    jsons["HeWeather5"][0]['now']['hum']
  end

  def wind
    jsons["HeWeather5"][0]['now']['wind']['spd']
  end

  def txt
    jsons["HeWeather5"][0]['now']['cond']['txt']
  end

  def wind_dir
    jsons["HeWeather5"][0]['now']['wind']['dir']
  end
end