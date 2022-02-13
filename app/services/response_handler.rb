# frozen_string_literal: true

class ResponseHandler
  attr_reader :recipes

  def initialize(raw_response:)
    @raw_response = raw_response
    @recipes = []
  end

  def parse
    return unless @raw_response.items.present?

    @raw_response.items.each do |item|
      recipe = Recipe.new(
        contentful_id: item.dig(:sys, :id),
        title: item.dig(:fields, :title)
      )

      recipe.photo = photo(item:)

      recipes << recipe
    end
  end

  private

  def photo(item:)
    photo_id = item.dig(:fields, :photo, :sys, :id)
    photo_asset = @raw_response.assets.find { |asset| asset.dig(:sys, :id) == photo_id }

    Photo.new(
      contentful_id: photo_id,
      url: "https:#{photo_asset.dig(:fields, :file, :url)}"
    )
  end
end
