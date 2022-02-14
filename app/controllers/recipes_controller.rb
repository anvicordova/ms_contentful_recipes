# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    service_response = ::RecipesService.new.call

    if service_response.success?
      builder = RecipesBuilder.new(
        raw_response: service_response.data
      )
      builder.parse
      @recipes = builder.recipes

      render :index, status: :ok
    else
      render "errors/#{service_response.status}", status: service_response.status
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
