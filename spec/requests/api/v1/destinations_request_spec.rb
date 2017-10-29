require 'rails_helper'

describe "Destinations API" do
  it "sends a list of destinations" do
    destinations = create_list(:destination, 5)

    get '/api/v1/destinations.json'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(json.class).to eq(Array)
    expect(json.count).to eq(5)
    expect(json[0][:name]).to eq(destinations[0].name)
    expect(json[1][:zip]).to eq(destinations[1].zip)
    expect(json[2][:description]).to eq(destinations[2].description)
    expect(json[3][:updated_at]).to be_nil
    expect(json[4][:created_at]).to be_nil
    expect(json[4][:image_url]).to be_nil
  end

  it "sends one destination" do
    destinations = create_list(:destination, 3)

    get "/api/v1/destinations/#{destinations[2].id}.json"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_success
    expect(json.class).to eq(Hash)
    expect(json[:name]).to eq(destinations[2].name)
    expect(json[:description]).to eq(destinations[2].description)
    expect(json[:name]).to_not eq(destinations[1].name)
    expect(json[:name]).to_not eq(destinations[0].name)
    expect(json[:updated_at]).to be_nil
    expect(json[:created_at]).to be_nil
    expect(json[:image_url]).to be_nil
  end

  it "can create a new destination" do
    destination_params = { name: "Lakewood", description: "where?", zip: "80204" }

    post "/api/v1/destinations", params: {destination: destination_params}
    destination = Destination.last

    expect(response).to be_success
    expect(destination.name).to eq(destination_params[:name])
    expect(destination.description).to eq(destination_params[:description])
    expect(destination.zip).to eq(destination_params[:zip])
  end

  it "can update an existing destination" do
    destinations = create_list(:destination, 3)
    previous_name = Destination.last.name
    destination_params = { name: "Wheat Ridge" }

    put "/api/v1/destinations/#{destinations[1].id}", params: {destination: destination_params}
    destination = Destination.find(destinations[1].id)

    expect(response).to be_success
    expect(destination.name).to_not eq(previous_name)
    expect(destination.name).to eq(destination_params[:name])
  end

  it "can destroy an destination" do
    destination = create(:destination)

    expect(Destination.count).to eq(1)

    #the line below is a fancy way of writing: expect(Destination.count).to eq(0)
    #this line could also be written: delete "/api/v1/destinations/#{destination.id}"
    #this is just doing two things at once, executing the delete method, and and expectation for the testing
    expect{delete "/api/v1/destinations/#{destination.id}"}.to change(Destination, :count).by(-1)

    expect(response).to be_success
    expect(Destination.count).to eq(0)
    expect{Destination.find(destination.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end

