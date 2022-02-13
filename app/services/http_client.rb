# frozen_string_literal: true

class HttpClient
  def initialize(url:, params: {}, headers: {})
    @connection = Faraday.new(
      url:,
      params:,
      headers:
    )
  end

  def fetch(endpoint:, params: {})
    response = @connection.get(endpoint, params)

    JSON.parse(response.body, symbolize_names: true)
  end
end
