# frozen_string_literal: true

class RecipeDetailsService
  def initialize(recipe_id:)
    @contentful_client = ::Contentful::Client.new
    @recipe_id = recipe_id
  end

  def call
    response = ResponseHandler.new(
      raw_response: @contentful_client.entries(
        content_type: 'recipe',
        other_params: {
          "sys.id": @recipe_id
        }
      )
    )
    response.parse
    response.recipes.first
  end
end
