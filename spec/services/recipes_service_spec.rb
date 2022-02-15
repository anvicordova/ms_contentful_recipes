# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipesService do
  subject { described_class.new }

  describe 'recipes' do
    it 'returns a contentful response' do
      VCR.use_cassette('recipes') do
        expect(subject.recipes).to be_a_kind_of(Contentful::Response)
      end
    end
  end

  describe 'recipe' do
    let(:recipe_id) { "2E8bc3VcJmA8OgmQsageas" }

    it 'returns a contentful response' do
      VCR.use_cassette('single_recipe') do
        expect(subject.recipe(recipe_id: recipe_id)).to be_a_kind_of(Contentful::Response)
      end
    end
  end
end