# frozen_string_literal: true

class ListRecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def call
    entries = @contentful_client.entries(
      content_type: 'recipe'
    )

    entries.items.map do |item|
      recipe = Recipe.new(
        contentful_id: item[:sys][:id],
        title: item[:fields][:title]
      )

      photo_id = item[:fields][:photo][:sys][:id]
      photo_asset = entries.assets.select { |item| item[:sys][:id] == photo_id }.first

      recipe.photo = Photo.new(
        contentful_id: photo_id,
        url: "https:#{photo_asset[:fields][:file][:url]}"
      )

      recipe
    end
  end
end
