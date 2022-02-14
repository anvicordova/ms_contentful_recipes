# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    service_response = ::RecipesService.new.recipes

    if service_response.success?
      @recipes = recipe_builder(service_response)

      render :index, status: :ok
    else
      render "errors/#{service_response.status}", status: service_response.status
    end
  end

  def show
    service_response = ::RecipesService.new.recipe(recipe_id: permitted_params)

    if service_response.success?
      @recipe = recipe_builder(service_response).first

      render :show, status: :ok
    else
      render "errors/#{service_response.status}", status: service_response.status
    end
  end

  private

  def recipe_builder(service_response)
    RecipesBuilder.new(
      raw_response: service_response.data
    ).parse
  end

  def permitted_params
    params.require(:id)
  end
end
