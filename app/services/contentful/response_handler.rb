# frozen_string_literal: true

module Contentful
  class ResponseHandler
    NOT_FOUND = :not_found
    SERVER_ERROR = :internal_server_error
    SUCCESS = :ok

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
      when 'NotFound'
        ::Contentful::Response.new(
          status: NOT_FOUND,
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
