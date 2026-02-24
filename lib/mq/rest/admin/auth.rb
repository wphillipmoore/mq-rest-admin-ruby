# frozen_string_literal: true

require 'cgi'

module MQ
  module REST
    module Admin
      # HTTP Basic authentication credentials.
      BasicAuth = Data.define(:username, :password)

      # LTPA token-based authentication credentials.
      # The session performs an LTPA login at construction time and uses
      # the returned LtpaToken2 cookie for subsequent requests.
      LTPAAuth = Data.define(:username, :password)

      # Mutual TLS (mTLS) client certificate authentication.
      # The client certificate is configured on the transport layer.
      # No Authorization header is sent.
      CertificateAuth = Data.define(:cert_path, :key_path) do
        def initialize(cert_path:, key_path: nil)
          super
        end
      end

      LTPA_COOKIE_NAME = 'LtpaToken2'
      LTPA_LOGIN_PATH = '/login'

      module_function

      def perform_ltpa_login(transport, rest_base_url, credentials, csrf_token:, timeout_seconds:, verify_tls:)
        login_url = "#{rest_base_url}#{LTPA_LOGIN_PATH}"
        headers = { 'Accept' => 'application/json' }
        headers['ibm-mq-rest-csrf-token'] = csrf_token unless csrf_token.nil?
        payload = { 'username' => credentials.username, 'password' => credentials.password }

        response = transport.post_json(
          login_url, payload,
          headers: headers, timeout_seconds: timeout_seconds, verify_tls: verify_tls
        )

        if response.status_code >= 400
          raise AuthError.new(
            'LTPA login failed.',
            url: login_url, status_code: response.status_code
          )
        end

        token = extract_ltpa_token(response.headers)
        if token.nil?
          raise AuthError.new(
            'LTPA login succeeded but no LtpaToken2 cookie was returned.',
            url: login_url, status_code: response.status_code
          )
        end

        token
      end

      def extract_ltpa_token(headers)
        set_cookie = headers['Set-Cookie'] || headers['set-cookie']
        return nil if set_cookie.nil? || set_cookie.empty?

        # Parse Set-Cookie header for LtpaToken2
        set_cookie.split(',').each do |cookie_str|
          parts = cookie_str.strip.split(';').first
          # :nocov:
          next if parts.nil?
          # :nocov:

          name, _, value = parts.partition('=')
          return value if name.strip == LTPA_COOKIE_NAME
        end
        nil
      end
    end
  end
end
