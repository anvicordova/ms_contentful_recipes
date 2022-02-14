# frozen_string_literal: true

module Contentful
  class Response
    attr_reader :data, :error, :status

    def initialize(success:, status:, data: nil, error: nil)
      @success = success
      @data = data
      @error = error
      @status = status
    end

    def success?
      @success
    end

    def failure?
      !@success
    end
  end
end
