# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'
require 'yaml'

module SmPs
  # Some helpers to setup and interact with various aws services.
  module AwsHelpers
    SSM_PARAMETER_TYPES = %w[String StringList SecureString].freeze

    def aws_region
      @region ||= initialize_aws_region
    end

    def credentials_from_role(role, debug = false)
      @aws_session ||= initialize_aws_session_from_role(role, debug)
      @aws_session.credentials
    end

    def configure_aws_region(region = nil)
      if region
        ::Aws.config.update(region: region)
      else
        ::Aws.config.update(region: aws_region)
      end
    end

    private

    def initialize_aws_session_from_role(role, debug)
      require 'awssession'
      require 'aws_config'
      profile = AWSConfig[role]
      profile['name'] = role
      session = AwsSession.new(profile: profile, debug: debug)
      session.start
      session
    end

    def initialize_aws_region
      url = 'http://169.254.169.254/latest/dynamic/instance-identity/document'
      JSON.parse(get_http(url))['region']
    end

    def get_http(url)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = 2
      http.open_timeout = 2
      response = http.start { |h| h.get(uri.path) }
      return response.body
    end
  end
end
