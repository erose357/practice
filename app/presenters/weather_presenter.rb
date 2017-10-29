class WeatherPresenter
  def initialize(destination)
    @destination = destination
  end

  def get_forecast 
    forecast_instances(api_call)
  end

  private
    attr_reader :destination

    def forecast_instances(raw_forecast)
      raw_forecast.map { |forecast| Forecast.new(forecast) }
    end

    def api_call
      WeatherService.new(destination.zip).ten_day_forecast
    end
end
