# frozen_string_literal: true

target :lib do
  signature 'sig'
  check 'lib'

  library 'json'
  library 'net-http'
  library 'openssl'
  library 'uri'
  library 'base64'
  library 'cgi'

  configure_code_diagnostics do |hash|
    # Data.define block methods are attributed to the enclosing module by Steep.
    hash[Steep::Diagnostic::Ruby::UndeclaredMethodDefinition] = :information

    # Empty collection literals are type-inferred from context.
    hash[Steep::Diagnostic::Ruby::UnannotatedEmptyCollection] = :information
  end
end
