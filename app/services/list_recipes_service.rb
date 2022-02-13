# frozen_string_literal: true

class ListRecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def call
    entries = @contentful_client.entries(
      content_type: 'recipe'
    )

    response = ResponseHandler.new(raw_response: entries)
    response.parse
    response.recipes
  end
end
