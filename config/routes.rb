Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :weather, only: [] do
        get :current
      end
    end
  end

  root to: 'api/v1/weathers#current'
end
