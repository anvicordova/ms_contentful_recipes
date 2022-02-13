# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = ::RecipesService.new.call
  end
end
