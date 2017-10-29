class Forecast
  attr_reader :high, :low, :conditions

  def initialize(attrs)
    @weekday = attrs[:date][:weekday]
    @month = attrs[:date][:month]
    @day = attrs[:date][:day]
    @high = attrs[:high][:fahrenheit]
    @low = attrs[:low][:fahrenheit]
    @conditions = attrs[:conditions]
    @city = attrs[:date][:tz_long]
  end

  def city
    @city.split('/')[1]
  end

  def info 
    "#{weekday} - #{month}/#{day}"
  end

  private
    attr_reader :weekday, :month, :day
end
