# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResponseHandler do
  subject do
    described_class.new(
      raw_response: Contentful::Client.new.entries(
        content_type: 'recipe'
      ).data
    )
  end

  describe 'entries' do
    it 'returns a Contentful::Response' do
      VCR.use_cassette('recipes') do
        subject.parse

        aggregate_failures do
          expect(subject.recipes.size).to be 4
          expect(subject.recipes.first).to have_attributes(
            title: 'White Cheddar Grilled Cheese with Cherry Preserves & Basil'
          )

          expect(subject.recipes.first.photo).to have_attributes(
            url: 'https://images.ctfassets.net/kk2bw5ojx476/61XHcqOBFYAYCGsKugoMYK/0009ec560684b37f7f7abadd66680179/SKU1240_hero-374f8cece3c71f5fcdc939039e00fb96.jpg'
          )
        end
      end
    end
  end
end
