# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Recipe management', type: :request do
  describe 'GET /recipes' do
    describe 'a valid request' do
      it 'has a :ok status code' do
        VCR.use_cassette('recipes') do
          get '/recipes'
          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe 'invalid request' do
      describe 'invalid token' do
        it 'has a :internal_server_error status code' do
          ClimateControl.modify CONTENTFUL_ACCESS_TOKEN: 'invalid-token' do
            VCR.use_cassette('recipes_invalid_token') do
              get '/recipes'
              expect(response).to have_http_status(:internal_server_error)
            end
          end
        end
      end

      describe 'invalid space' do
        let(:base_path) do
          [
            ENV['CONTENTFUL_API_BASE_URL'],
            '/spaces/invalid-space',
            '/environments/', ENV['CONTENTFUL_ENVIRONMENT_ID'], '/'
          ].join
        end

        it 'has a :not_found status code' do
          VCR.use_cassette('recipes_invalid_space') do
            stub_const('Contentful::Client::BASE_PATH', base_path)

            get '/recipes'
            expect(response).to have_http_status(:not_found)
          end
        end
      end
    end
  end

  describe 'GET /recipe' do
    describe 'a valid request' do
      let(:recipe_id) { '2E8bc3VcJmA8OgmQsageas' }

      it 'has a :ok status code' do
        VCR.use_cassette('single_recipe') do
          get "/recipes/#{recipe_id}"

          expect(response).to have_http_status(:ok)
        end
      end
    end

    describe 'invalid request' do
      let(:recipe_id) { 'random_recipe' }

      it 'has a :not_found status code' do
        VCR.use_cassette('not_found_single_recipe') do
          get "/recipes/#{recipe_id}"

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
