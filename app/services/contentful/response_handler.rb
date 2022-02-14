# frozen_string_literal: true

module Contentful
  class ResponseHandler
    NOT_FOUND = 404
    SERVER_ERROR = :internal_server_error
    SUCCESS = 200

    def initialize(body:)
      @body = body
    end

    def handle
      case @body.dig(:sys, :id)
      when 'AccessTokenInvalid'
        ::Contentful::Response.new(
          status: SERVER_ERROR,
          error: 'Something went wrong',
          success: false
        )
      else
        ::Contentful::Response.new(
          status: SUCCESS,
          success: true,
          data: @body
        )
      end
    end
  end
end
