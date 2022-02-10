require "rails_helper"

RSpec.describe Contentful::Client do
  subject { described_class.new }

  describe 'entries' do
    it do
      expect(subject.entries(content_type: "recipe")).to eq([])
    end
  end
end