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

      recipe.photo = Builders::Photo.new(item:, raw_response: @raw_response).call
      recipe.chef = Builders::Chef.new(item:, raw_response: @raw_response).call
      recipe.tags = Builders::Tags.new(item:, raw_response: @raw_response).call

      recipes << recipe
    end
  end
end
