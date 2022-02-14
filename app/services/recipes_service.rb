# frozen_string_literal: true

class RecipesService
  def initialize
    @contentful_client = ::Contentful::Client.new
  end

  def call
    @contentful_client.entries(content_type: 'recipe')
  end
end
