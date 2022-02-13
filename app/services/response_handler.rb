# frozen_string_literal: true

class ResponseHandler
  attr_reader :recipes

  def initialize(raw_response:)
    @raw_response = raw_response
    @recipes = []
  end

  def parse
    @raw_response.items.each do |item|
      recipe = Recipe.new(
        contentful_id: item[:sys][:id],
        title: item[:fields][:title]
      )

      photo = photo_asset(item)

      recipe.photo = Photo.new(
        contentful_id: photo[:photo_id],
        url: "https:#{photo[:url]}"
      )

      recipes << recipe
    end
  end

  private

  def photo_asset(item)
    photo_id = item[:fields][:photo][:sys][:id]
    photo_asset = @raw_response.assets.find { |asset| asset[:sys][:id] == photo_id }

    {
      photo_id:,
      url: photo_asset[:fields][:file][:url]
    }
  end
end
