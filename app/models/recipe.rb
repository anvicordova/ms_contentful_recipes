# frozen_string_literal: true

class Recipe
  attr_accessor :title, :photo, :contentful_id, :calories, :description, :chef, :tags

  def initialize(contentful_id:, title:, calories: nil, description: nil)
    @contentful_id = contentful_id
    @title = title
    @calories = calories
    @description = description
  end
end
