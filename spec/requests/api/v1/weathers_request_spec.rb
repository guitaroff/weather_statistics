require 'rails_helper'

RSpec.describe Api::V1::WeathersController, type: :request do
  describe 'GET #current' do
    let(:api_key) { '15unCqZqrCDnjKGHi2TxFZaR1sXvVV0E' }
    let(:location_key) { '294021' }
    let(:api_url) { "http://dataservice.accuweather.com/currentconditions/v1/#{location_key}" }

    subject { get current_api_v1_weather_path }

    context 'success response' do
      it 'returns the current weather data' do
        stub_request(:get, api_url)
          .with(query: { apikey: api_key })
          .to_return(status: 200, body: '[{"Temperature": {"Metric": {"Value": 22}}}]', headers: {})

        subject

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([{ 'Temperature' => { 'Metric' => { 'Value' => 22 } } }])
      end
    end

    context 'unprocessable entity' do
      it 'returns an error message' do
        stub_request(:get, api_url)
          .with(query: { apikey: api_key })
          .to_return(status: 422, body: 'Failed to fetch weather data', headers: {})

        subject

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to eq('error' => 'Failed to fetch weather data')
      end
    end
  end
end
