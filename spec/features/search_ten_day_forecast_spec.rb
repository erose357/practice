require 'rails_helper'

RSpec.describe "Destination page" do
  it "show the 10 forecast for the destination" do
    VCR.use_cassette("forecast") do
      city = create(:destination)
  #As a user
  #When I visit "/"
      visit '/'
  #And I click on a destination

      find(".picture").click
      #Then I should be on page "/destinations/:id"
      expect(current_path).to eq("/destinations/#{city.id}")
  #Then I should see the destination's name, zipcode, description, and 10 day weather forecast

      expect(page).to have_content(city.name)
      expect(page).to have_content(city.zip)
      expect(page).to have_content(city.description)
  #The weather forecast is specific to the destination whose page I'm on
      expect(page).to have_content("Forecast for #{city.name}")
  #The forecast should include date (weekday, month and day), high and low temps (F), and weather conditions
      expect(page).to have_css(".day_time")
      expect(page).to have_css(".high-temp")
      expect(page).to have_css(".low-temp")
      expect(page).to have_css(".weather")
    end
  end
end
