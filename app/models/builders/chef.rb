# frozen_string_literal: true

module Builders
  class Chef < Item
    def build
      chef_id = @item.dig(:fields, :chef, :sys, :id)

      return unless chef_id

      chef_entry = match_entry(entries: @raw_response.dig(:includes, :Entry), id: chef_id)

      ::Chef.new(
        contentful_id: chef_id,
        name: chef_entry.dig(:fields, :name)
      )
    end
  end
end
