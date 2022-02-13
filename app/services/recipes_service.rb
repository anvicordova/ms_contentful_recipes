# frozen_string_literal: true

class RecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def call
    response = ResponseHandler.new(
      raw_response: @contentful_client.entries(
        content_type: 'recipe'
      )
    )
    response.parse
    response.recipes
  end
end
