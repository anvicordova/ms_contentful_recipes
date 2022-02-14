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

    def entries(content_type:, selected_fields: [], other_params: {})
      entries = fetch(
        endpoint: 'entries',
        content_type:,
        selected_fields:,
        other_params:
      )

      Response.new(
        success: true,
        data: OpenStruct.new(
          items: entries[:items],
          assets: entries.dig(:includes, :Asset),
          included_entries: entries.dig(:includes, :Entry)
        )
      )
    rescue HttpClient::Error => e
      Response.new(success: false, error: e)
    end

    private

    def fetch(endpoint:, other_params:, content_type: '', selected_fields: [])
      @client.fetch(
        endpoint:,
        params: {
          content_type:,
          select: selected_fields.join('&')
        }.merge(other_params)
      )
    end
  end
end
