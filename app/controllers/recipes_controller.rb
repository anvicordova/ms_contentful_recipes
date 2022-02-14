# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = ::RecipesService.new.call
  end

  def show
    @recipe = ::RecipeDetailsService.new(recipe_id: permitted_params).call
  end

  private 

  def permitted_params
    params.require(:id)
  end
end
