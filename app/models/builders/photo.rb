# frozen_string_literal: true

module Builders
  class Photo < Item
    def build
      photo_id = @item.dig(:fields, :photo, :sys, :id)
      photo_asset = match_entry(entries: @raw_response.dig(:includes, :Asset), id: photo_id)

      ::Photo.new(
        contentful_id: photo_id,
        url: "https:#{photo_asset.dig(:fields, :file, :url)}"
      )
    end
  end
end
