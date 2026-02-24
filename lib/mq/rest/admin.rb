# frozen_string_literal: true

require_relative 'admin/version'
require_relative 'admin/errors'
require_relative 'admin/auth'
require_relative 'admin/transport'
require_relative 'admin/mapping_data'
require_relative 'admin/mapping'
require_relative 'admin/mapping_merge'
require_relative 'admin/commands'
require_relative 'admin/ensure'
require_relative 'admin/sync'
require_relative 'admin/session'

# Top-level namespace for the MQ REST Admin library.
module MQ
  # REST API namespace.
  module REST
  end
end
