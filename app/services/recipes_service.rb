# frozen_string_literal: true

class RecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def recipes
    @contentful_client.entries(content_type: 'recipe')
  end

  def recipe(recipe_id:)
    @contentful_client.entries(
      content_type: 'recipe',
      other_params: {
        'sys.id': recipe_id
      }
    )
  end
end
