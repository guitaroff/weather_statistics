class Api::V1::WeathersController < ApplicationController
  def current
    response = WeatherRequest.new.current_data
    return render_422 unless response.success?

    render json: JSON.parse(response.body)
  end

  def historical
    response = WeatherRequest.new.historical_data
    return render_422 unless response.success?

    render json: JSON.parse(response.body)
  end

  def historical_max
    response = WeatherRequest.new.historical_data
    return render_422 unless response.success?

    weather_data = prepare_weather_data(response.body)
    render json: weather_data.max
  end

  def historical_min
    response = WeatherRequest.new.historical_data
    return render_422 unless response.success?

    weather_data = prepare_weather_data(response.body)
    render json: weather_data.min
  end

  def historical_avg
    response = WeatherRequest.new.historical_data
    return render_422 unless response.success?

    weather_data = prepare_weather_data(response.body)
    render json: avg_data(weather_data)
  end

  private

  def render_422
    render json: { error: 'Failed to fetch weather data' }, status: 422
  end

  def prepare_weather_data(response_body)
    weather_data = JSON.parse(response_body)
    weather_data.map { |el| el&.dig('Temperature')&.dig('Metric')&.dig('Value') }
  end

  def avg_data(weather_data)
    (weather_data.sum(0.0) / weather_data.size).round(2)
  end
end
