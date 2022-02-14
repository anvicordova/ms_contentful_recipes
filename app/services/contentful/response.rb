# frozen_string_literal: true

module Contentful
  class Response
    attr_reader :items, :assets, :included_entries

    def initialize(items:, assets:, included_entries:)
      @items = items
      @assets = assets
      @included_entries = included_entries
    end
  end
end
