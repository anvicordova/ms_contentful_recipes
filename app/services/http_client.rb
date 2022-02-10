class HttpClient
  def initialize(url:, params:{}, headers:[])
    @connection = Faraday.new(
      url: url,
      params: params,
      headers: headers
    )
  end

  def fetch(endpoint:, params: {})
    debugger
    response = @connection.get(endpoint, params)
    debugger
    body = JSON.parse(response.body, symbolize_names: true)

    if response.success?
      body[:data]
    else
      body[:data]
    end
  end
end
