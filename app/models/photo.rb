# frozen_string_literal: true

class Photo
  attr_accessor :url

  def initialize(contentful_id:, url:)
    @contentful_id = contentful_id
    @url = url
  end
end
