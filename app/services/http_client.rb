# frozen_string_literal: true

class HttpClient
  def initialize(url:, response_handler:, params: {}, headers: {})
    @connection = Faraday.new(
      url:,
      params:,
      headers:
    )

    @response_handler = response_handler
  end

  def fetch(endpoint:, params: {})
    begin
      response = @connection.get(endpoint, params)
      body = JSON.parse(response.body, symbolize_names: true)
    rescue StandardError
      # log
      # add rescues
    end
    @response_handler.new(body:).handle
  end
end
