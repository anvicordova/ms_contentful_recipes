# frozen_string_literal: true

module Builders
  class Item
    def initialize(item:, raw_response:)
      @item = item
      @raw_response = raw_response
    end

    def match_entry(entries:, id:)
      entries.find { |entry| entry.dig(:sys, :id) == id }
    end
  end
end
