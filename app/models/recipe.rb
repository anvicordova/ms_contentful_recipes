# frozen_string_literal: true

class Recipe
  attr_accessor :title, :photo

  def initialize(contentful_id:, title:)
    @contentful_id = contentful_id
    @title = title
  end
end
