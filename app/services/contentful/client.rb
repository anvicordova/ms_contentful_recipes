# frozen_string_literal: true

module Contentful
  class Client
    BASE_PATH = [
      ENV['CONTENTFUL_API_BASE_URL'],
      "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/",
      "environments/#{ENV['CONTENTFUL_ENVIRONMENT_ID']}/"
    ].join

    def initialize
      @http_client = ::HttpClient.new(
        url: BASE_PATH,
        headers: {
          Authorization: "Bearer #{ENV['CONTENTFUL_ACCESS_TOKEN']}"
        },
        response_handler: Contentful::ResponseHandler
      )
    end

    def entries(content_type:, selected_fields: [], other_params: {})
      fetch(
        endpoint: 'entries',
        content_type:,
        selected_fields:,
        other_params:
      )
    end

    private

    def fetch(endpoint:, other_params:, content_type: '', selected_fields: [])
      @http_client.fetch(
        endpoint:,
        params: {
          content_type:,
          select: selected_fields.join('&')
        }.merge(other_params)
      )
    end
  end
end
