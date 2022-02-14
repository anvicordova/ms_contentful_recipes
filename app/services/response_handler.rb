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
        title: item.dig(:fields, :title),
        calories: item.dig(:fields, :calories),
        description: item.dig(:fields, :description)
      )

      recipe.photo = photo(item:)
      recipe.chef = chef(item:)

      recipes << recipe
    end
  end

  private

  def chef(item:)
    chef_id = item.dig(:fields, :chef, :sys, :id)
    
    return unless chef_id
    
    chef_entry = @raw_response.included_entries.find { |entry| entry.dig(:sys, :id) == chef_id }

    Chef.new(
      contentful_id: chef_id,
      name: chef_entry.dig(:fields, :name)
    )
  end


  def photo(item:)
    photo_id = item.dig(:fields, :photo, :sys, :id)
    photo_asset = @raw_response.assets.find { |asset| asset.dig(:sys, :id) == photo_id }

    Photo.new(
      contentful_id: photo_id,
      url: "https:#{photo_asset.dig(:fields, :file, :url)}"
    )
  end
end
