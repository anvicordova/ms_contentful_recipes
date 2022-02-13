# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    @recipes = ::ListRecipesService.new.call
  end
end
