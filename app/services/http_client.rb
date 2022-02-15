# frozen_string_literal: true

class HttpClient
  DEFAULT_TIMEOUT = 3 # seconds

  def initialize(url:, response_handler:, params: {}, headers: {})
    @connection = Faraday.new(
      url:,
      params:,
      headers:,
      request: { timeout: DEFAULT_TIMEOUT }
    )

    @response_handler = response_handler
  end

  def fetch(endpoint:, params: {})
    begin
      response = @connection.get(endpoint, params)
      body = JSON.parse(response.body, symbolize_names: true)

    rescue Faraday::TimeoutError => e
      Rails.logger.error "Request Timeout: #{e}"
    end
    @response_handler.new(body:).handle
  end
end
