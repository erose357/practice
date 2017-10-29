class WeatherService
  def initialize(zip)
    @zip = zip
  end

  def ten_day_forecast
    json_parse(get_url)
  end

  private
    attr_reader :zip

    def json_parse(raw_json)
      JSON.parse(raw_json.body, symbolize_names: true)[:forecast][:simpleforecast][:forecastday]
    end

    def get_url
      Faraday.get("http://api.wunderground.com/api/#{ENV["weather_key"]}/forecast10day/q/#{zip}.json")
    end
end
