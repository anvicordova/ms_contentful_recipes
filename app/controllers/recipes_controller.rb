# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = ::RecipesService.new.call

    if @recipes
      render :index, status: :ok
    else
      render template: 'errors/internal_server', status: :internal_server_error
    end
  end

  def show
    @recipe = ::RecipeDetailsService.new(recipe_id: permitted_params).call
  end

  private

  def permitted_params
    params.require(:id)
  end
end
