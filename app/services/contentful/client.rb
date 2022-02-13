# frozen_string_literal: true

module Contentful
  class Client
    BASE_PATH = [
      ENV['CONTENTFUL_API_BASE_URL'],
      "/spaces/#{ENV['CONTENTFUL_SPACE_ID']}/",
      "environments/#{ENV['CONTENTFUL_ENVIRONMENT_ID']}/"
    ].join

    def initialize
      @client = ::HttpClient.new(
        url: BASE_PATH,
        headers: {
          Authorization: "Bearer #{ENV['CONTENTFUL_ACCESS_TOKEN']}"
        }
      )
    end

    def entries(content_type:, selected_fields: [])
      entries = fetch(content_type:, selected_fields:)

      Response.new(
        items: entries[:items],
        assets: entries.dig(:includes, :Asset)
      )
    end

    def fetch(content_type:, selected_fields: [])
      debugger
      @client.fetch(
        endpoint: 'entries',
        params: {
          content_type:,
          select: selected_fields.join('&')
        }
      )
    end
  end
end
