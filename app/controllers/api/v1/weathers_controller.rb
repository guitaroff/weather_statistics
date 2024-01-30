class Api::V1::WeathersController < ApplicationController
  def current
    response = WeatherRequest.new.current_data

    if response.success?
      render json: JSON.parse(response.body)
    else
      render json: { error: 'Failed to fetch weather data' }, status: 422
    end
  end
end
