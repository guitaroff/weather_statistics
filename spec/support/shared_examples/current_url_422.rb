RSpec.shared_examples 'current_url 422' do
  context 'unprocessable entity' do
    it 'returns an error message' do
      stub_request(:get, current_url)
        .with(query: { apikey: api_key })
        .to_return(status: 422, body: 'Failed to fetch weather data', headers: {})

      subject

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq('error' => 'Failed to fetch weather data')
    end
  end
end

RSpec.shared_examples 'historical_url 422' do
  context 'unprocessable entity' do
    it 'returns an error message' do
      stub_request(:get, historical_url)
        .with(query: { apikey: api_key })
        .to_return(status: 422, body: 'Failed to fetch weather data', headers: {})

      subject

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to eq('error' => 'Failed to fetch weather data')
    end
  end
end
