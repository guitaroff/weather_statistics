require 'httparty'

class WeatherRequest
  include HTTParty
  base_uri 'http://dataservice.accuweather.com'

  def current_data
    self.class.get(current_data_path, query: options)
  end

  def historical_data
    self.class.get(historical_data_path, query: options)
  end

  private

  def api_key
    ENV['WEATHER_API_KEY'] || '15unCqZqrCDnjKGHi2TxFZaR1sXvVV0E'
  end

  def location_key
    ENV['LOCATION_KEY'] || '294021'
  end

  def options
    { apikey: api_key }
  end

  def current_data_path
    "/currentconditions/v1/#{location_key}"
  end

  def historical_data_path
    "#{current_data_path}/historical/24"
  end
end
