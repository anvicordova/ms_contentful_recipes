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
      recipe = build(item:, type: :Recipe)
      recipe.photo = build(item:, type: :Photo)
      recipe.chef = build(item:, type: :Chef)
      recipe.tags = build(item:, type: :Tags)

      recipes << recipe
    end

    recipes
  end

  private

  def build(item:, type:)
    Builders.const_get(type.to_s).new(item:, raw_response: @raw_response).build
  end
end
