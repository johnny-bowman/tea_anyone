require 'rails_helper'

RSpec.describe 'Subscription request' do
  before :each do
    User.destroy_all
    Subscription.destroy_all
    Subscription.reset_pk_sequence # this is from the 'activerecord-reset-pk-sequence' gem that resets the id incrementation of table.
    User.create!(id: 1, first_name: "test", last_name: "person", email: "test@nah.com", address: "123 Test St")
    Tea.create!(title: 'Green Tea', description: 'maaan this is good tea', temp: 177, brew_time: 2, price: 5.50)
    Tea.create!(title: 'White Tea', description: 'mmmmm tea', temp: 180, brew_time: 3, price: 4.99)
  end

  describe 'happy paths' do
    it 'returns subscription id, status, frequency, price, and tea titles' do
      params = {
        "user_id": "1",
        "tea": [
          "Green Tea",
          "White Tea"
        ],
        "frequency": "2"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/subscription", headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(201)
      params = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(params[:id]).to eq(1)
      expect(params[:type]).to eq('subscription')

      expect(params[:attributes][:status]).to eq('active')
      expect(params[:attributes][:frequency]).to eq(2)
      expect(params[:attributes][:price]).to eq(10.49)
      expect(params[:attributes][:teas]).to all(be_an String)
    end

    it 'cancels subscriptions' do
      Subscription.create!(price: 11.50, status: 0, frequency: 2, user_id: 1)

      patch "/api/v1/subscription/1"

      expect(response.status).to eq(200)
      params = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(params[:id]).to eq(1)
      expect(params[:type]).to eq('subscription')

      expect(params[:message]).to eq('Subscription canceled.')
    end

    it 'returns all user subscriptions' do
      Subscription.create!(price: 11.50, status: 0, frequency: 2, user_id: 1)
      Subscription.create!(price: 13.50, status: 0, frequency: 4, user_id: 1)

      get "/api/v1/users/1/subscriptions"

      expect(response.status).to eq(200)
      params = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(params[:user_id]).to eq(1)
      expect(params[:type]).to eq('user_subscriptions')

      expect(params[:subscriptions]).to be_an(Array)
      expect(params[:subscriptions][0][:price]).to eq(11.50)
      expect(params[:subscriptions][1][:price]).to eq(13.50)
    end
  end

  describe 'sad paths' do
    it "returns error if frequency is not an integer, or user doesn't exist" do
      params = {
        "user_id": "100",
        "tea": [
            "Green Tea",
            "White Tea"
        ],
        "frequency": "poop"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/subscription", headers: headers, params: JSON.generate(params)

      expect(response.status).to eq(400)
      error = JSON.parse(response.body, symbolize_names: true)[:errors].first

      expect(error[:message]).to eq('User must exist and Frequency is not a number')
    end
  end
end
