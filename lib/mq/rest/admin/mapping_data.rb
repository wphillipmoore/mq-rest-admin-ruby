# frozen_string_literal: true

require 'json'

module MQ
  module REST
    module Admin
      JSON_PATH = File.join(__dir__, 'mapping-data.json')
      MAPPING_DATA = JSON.parse(File.read(JSON_PATH)).freeze
    end
  end
end
