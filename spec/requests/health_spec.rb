require 'rails_helper'

RSpec.describe HealthController, type: :request do
  describe 'GET /health/status' do
    it 'success response' do
      get health_path
      expect(response).to have_http_status(:ok)
    end
  end
end
