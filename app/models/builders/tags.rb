# frozen_string_literal: true

module Builders
  class Tags < Item
    def build
      tag_entries = @item.dig(:fields, :tags) || []

      tag_entries.map do |entry|
        tag_id = entry.dig(:sys, :id)

        next unless tag_id

        tag_entry = match_entry(entries: @raw_response.dig(:includes, :Entry), id: tag_id)

        Tag.new(
          contentful_id: tag_id,
          name: tag_entry.dig(:fields, :name)
        )
      end
    end
  end
end
