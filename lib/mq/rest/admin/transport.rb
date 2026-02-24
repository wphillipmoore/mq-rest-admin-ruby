# frozen_string_literal: true

require 'json'
require 'net/http'
require 'openssl'
require 'uri'

module MQ
  module REST
    module Admin
      # Container for the raw HTTP response returned by a transport.
      TransportResponse = Data.define(:status_code, :body, :headers)

      # Default transport implementation using Net::HTTP.
      # Duck type contract: #post_json(url, payload, headers:, timeout_seconds:, verify_tls:)
      class NetHTTPTransport
        def initialize(client_cert: nil, client_key: nil)
          @client_cert = client_cert
          @client_key = client_key
        end

        def post_json(url, payload, headers:, timeout_seconds:, verify_tls:)
          uri = URI.parse(url)
          http = build_http(uri, timeout_seconds: timeout_seconds, verify_tls: verify_tls)
          request = build_request(uri, payload, headers)

          response = http.request(request)
          TransportResponse.new(
            status_code: response.code.to_i,
            body: response.body || '',
            headers: extract_headers(response)
          )
        rescue StandardError => e
          # :nocov:
          raise e if e.is_a?(Error)
          # :nocov:

          raise TransportError.new('Failed to reach MQ REST endpoint.', url: url)
        end

        private

        def build_http(uri, timeout_seconds:, verify_tls:)
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = (uri.scheme == 'https')
          http.verify_mode = verify_tls ? OpenSSL::SSL::VERIFY_PEER : OpenSSL::SSL::VERIFY_NONE

          if timeout_seconds
            http.open_timeout = timeout_seconds
            http.read_timeout = timeout_seconds
            http.write_timeout = timeout_seconds
          end

          if @client_cert
            http.cert = OpenSSL::X509::Certificate.new(File.read(@client_cert))
            http.key = OpenSSL::PKey::RSA.new(File.read(@client_key)) if @client_key
          end

          http
        end

        def build_request(uri, payload, headers)
          request = Net::HTTP::Post.new(uri)
          request.content_type = 'application/json'
          headers.each { |key, value| request[key] = value }
          request.body = JSON.generate(payload)
          request
        end

        def extract_headers(response)
          result = {}
          response.each_header { |key, value| result[key] = value }
          result
        end
      end
    end
  end
end
