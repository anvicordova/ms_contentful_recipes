# frozen_string_literal: true

class ListRecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def call
    entries = @contentful_client.entries(
      content_type: 'recipe'
    )

    entries[:items].map do |entry|
      recipe = Recipe.new(
        contentful_id: entry[:sys][:id],
        title: entry[:fields][:title]
      )

      photo_id = entry[:fields][:photo][:sys][:id]
      photo_asset = entries[:assets].select { |item| item[:sys][:id] == photo_id }.first

      recipe.photo = Photo.new(
        contentful_id: photo_id,
        url: "https:#{photo_asset[:fields][:file][:url]}"
      )

      recipe
    end
  end
end

