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
        before :each do
          stub_const('ENV', { 'CONTENTFUL_ACCESS_TOKEN' => 'invalid-token' })
        end

        it 'has a :internal_server_error status code' do
          VCR.use_cassette('recipes_invalid_token') do
            get '/recipes'
            expect(response).to have_http_status(:internal_server_error)
          end
        end
      end
    end
  end
end
