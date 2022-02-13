# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contentful::Client do
  subject { described_class.new }

  describe 'entries' do
    it 'returns a Contentful::Response' do
      VCR.use_cassette('recipes') do
        expect(subject.entries(content_type: 'recipe')).to be_a_kind_of(Contentful::Response)
      end
    end
  end
end
