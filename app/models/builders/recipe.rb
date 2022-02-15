# frozen_string_literal: true

module Builders
  class Recipe < Item
    def build
      ::Recipe.new(
        contentful_id: @item.dig(:sys, :id),
        title: @item.dig(:fields, :title),
        calories: @item.dig(:fields, :calories),
        description: @item.dig(:fields, :description)
      )
    end
  end
end
