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
end
