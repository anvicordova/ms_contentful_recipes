# frozen_string_literal: true

class RecipesBuilder
  attr_reader :recipes

  def initialize(raw_response:)
    @raw_response = raw_response
    @recipes = []
  end

  def parse
    return unless @raw_response[:items].present?

    @raw_response[:items].each do |item|
      recipe = Builders::Recipe.new(item:, raw_response: @raw_response).call
      recipe.photo = Builders::Photo.new(item:, raw_response: @raw_response).call
      recipe.chef = Builders::Chef.new(item:, raw_response: @raw_response).call
      recipe.tags = Builders::Tags.new(item:, raw_response: @raw_response).call

      recipes << recipe
    end
  end
end
