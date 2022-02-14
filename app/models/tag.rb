# frozen_string_literal: true

class Tag
  attr_accessor :name

  def initialize(contentful_id:, name:)
    @contentful_id = contentful_id
    @name = name
  end
end
