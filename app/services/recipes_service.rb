# frozen_string_literal: true

class RecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def call
    response = @contentful_client.entries(content_type: 'recipe')

    if response.success?
      handler = ResponseHandler.new(
        raw_response: response.data
      )
      handler.parse
      handler.recipes
    else
      false
    end
  end
end
