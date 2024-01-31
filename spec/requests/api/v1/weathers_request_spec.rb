require 'rails_helper'

RSpec.describe Api::V1::WeathersController, type: :request do
  let(:api_key) { '15unCqZqrCDnjKGHi2TxFZaR1sXvVV0E' }
  let(:location_key) { '294021' }
  let(:base_url) { 'http://dataservice.accuweather.com' }
  let(:current_url) { "#{base_url}/currentconditions/v1/#{location_key}" }
  let(:historical_url) { "#{current_url}/historical/24" }

  describe 'GET #current' do
    subject { get current_api_v1_weather_path }

    context 'success response' do
      it 'returns the current weather data' do
        stub_request(:get, current_url)
          .with(query: { apikey: api_key })
          .to_return(status: 200, body: '[{"Temperature": {"Metric": {"Value": 22}}}]', headers: {})

        subject

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to eq([{ 'Temperature' => { 'Metric' => { 'Value' => 22 } } }])
      end
    end

    it_behaves_like 'current_url 422'
  end

  describe 'GET #historical' do
    subject { get historical_api_v1_weather_path }

    context 'success response' do
      it 'returns the current weather data' do
        stub_request(:get, historical_url)
          .with(query: { apikey: api_key })
          .to_return(status: 200, body: '[{"Temperature": {"Metric": {"Value": 22}}}, {"Temperature": {"Metric": {"Value": 23}}}, {"Temperature": {"Metric": {"Value": 20}}}]', headers: {})

        subject

        expect(response).to have_http_status(:success)
        expect(
          JSON.parse(response.body)
        ).to eq([
          { 'Temperature' => { 'Metric' => { 'Value' => 22 } } },
          { 'Temperature' => { 'Metric' => { 'Value' => 23 } } },
          { 'Temperature' => { 'Metric' => { 'Value' => 20 } } }
        ])
      end
    end

    it_behaves_like 'historical_url 422'
  end

  describe 'GET #historical_max' do
    subject { get api_v1_weather_historical_max_path }

    context 'success response' do
      it 'return max temp data' do
        stub_request(:get, historical_url)
          .with(query: { apikey: api_key })
          .to_return(
            status: 200,
            body: '[{"Temperature": {"Metric": {"Value": 22}}}, {"Temperature": {"Metric": {"Value": 23}}}, {"Temperature": {"Metric": {"Value": 20}}}]',
            headers: {}
          )

        subject

        expect(response).to have_http_status(:success)
        expect(response.body).to eq('23')
      end
    end

    it_behaves_like 'historical_url 422'
  end

  describe 'GET #historical_min' do
    subject { get api_v1_weather_historical_min_path }

    context 'success response' do
      it 'return min temp data' do
        stub_request(:get, historical_url)
          .with(query: { apikey: api_key })
          .to_return(
            status: 200,
            body: '[{"Temperature": {"Metric": {"Value": 22}}}, {"Temperature": {"Metric": {"Value": 23}}}, {"Temperature": {"Metric": {"Value": 20}}}]',
            headers: {}
          )

        subject

        expect(response).to have_http_status(:success)
        expect(response.body).to eq('20')
      end
    end

    it_behaves_like 'historical_url 422'
  end

  describe 'GET #historical_avg' do
    subject { get api_v1_weather_historical_avg_path }

    context 'success response' do
      it 'return avg temp data' do
        stub_request(:get, historical_url)
          .with(query: { apikey: api_key })
          .to_return(
            status: 200,
            body: '[{"Temperature": {"Metric": {"Value": 22.0}}}, {"Temperature": {"Metric": {"Value": 23.0}}}, {"Temperature": {"Metric": {"Value": 20.0}}}]',
            headers: {}
          )

        subject

        expect(response).to have_http_status(:success)
        expect(response.body).to eq('21.67')
      end
    end

    it_behaves_like 'historical_url 422'
  end
end
