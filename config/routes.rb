Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :weather, only: [] do
        get :current
        get :historical
      end

      get '/weather/historical/max', to: 'weathers#historical_max'
      get '/weather/historical/min', to: 'weathers#historical_min'
      get '/weather/historical/avg', to: 'weathers#historical_avg'
    end
  end

  get '/health', to: 'health#status'

  root to: 'api/v1/weathers#current'
end
