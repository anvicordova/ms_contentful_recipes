# frozen_string_literal: true

module Contentful
  class Response
    attr_reader :items, :assets

    def initialize(items:, assets:)
      @items = items
      @assets = assets
    end
  end
end
