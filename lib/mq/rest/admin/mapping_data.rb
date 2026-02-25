# frozen_string_literal: true

require 'json'

module MQ
  module REST
    module Admin
      # @return [String] absolute path to the mapping data JSON file
      JSON_PATH = File.join(__dir__, 'mapping-data.json') # steep:ignore

      # @return [Hash{String => Object}] frozen mapping data loaded from the JSON file
      MAPPING_DATA = JSON.parse(File.read(JSON_PATH)).freeze
    end
  end
end
