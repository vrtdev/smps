# frozen_string_literal: true

require 'thor'
require 'smps/aws'
require 'smps/client'

module SmPs
  # Thor CLI Application.
  class CLI < Thor
    include SmPs::AwsHelpers

    def self.exit_on_failure?
      true
    end

    class_option 'role',
                 desc:"IAM profile/role to use. From ~/.aws/config",
                 default: nil,
                 banner: 'PROFILE',
                 long_desc: <<-LONGDESC
                      The profile should exist in your configuration file and provide the
                      information.
                 LONGDESC

    class_option 'region',
                 desc: 'Override the aws region',
                 default: nil

    class_option 'debug',
                 desc: 'AwsSession debug level.',
                 default: 0,
                 type: :numeric


    desc 'get NAME', 'Get path or path indicated by the name'
    long_desc <<-LONGDESC
    Gets a value from the parameter store.
    LONGDESC
    def get(name)
      parameter = get_parameter(name)
      puts parameter.to_s
    end

    private

    def get_parameter(name)
      smps.parameter(name: name, type: options['type'], key_id: options['key'])
    end

    def credentials
      if options['role']
        credentials_from_role(options['role'], options['debug'])
      else
        configure_aws_region(options['region'])
        nil
      end
    end

    def smps
      @smps ||= SmPs::Client.new(credentials: credentials)
    end

  end
end
