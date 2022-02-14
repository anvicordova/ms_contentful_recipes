# frozen_string_literal: true

class HttpClient
  class Error < StandardError
    def initialize(body)
      @exception_type = 'HttpClient error'
      super(body.inspect.to_s)
    end
  end

  def initialize(url:, params: {}, headers: {})
    @connection = Faraday.new(
      url:,
      params:,
      headers:
    )
  end

  def fetch(endpoint:, params: {})
    response = @connection.get(endpoint, params)
    body = JSON.parse(response.body, symbolize_names: true)

    if response.success?
      body
    else
      raise HttpClient::Error, body
    end
  end
end
