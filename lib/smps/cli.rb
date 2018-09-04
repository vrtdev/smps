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

    desc 'set NAME VALUE', 'Set the parameter to this value'
    option 'type', default: 'String', required: true
    option 'key',
           desc: 'KMS key for SecureString encryption/decryption',
           banner: 'ARN',
           long_desc: <<-LONGDESC
                    This should be the arn of the key or the name of the field in the
                    user-data if using userdata mode.
    LONGDESC
    def set(name, value)
      validate_parameter_type(options['type'])
      parameter = get_parameter(name)
      parameter = create_parameter(parameter, options['type'], options['key']) unless parameter.exists?
      parameter.write!(value)
      puts parameter.to_s
    end

    protected

    def create_parameter(parameter, type, key)
      raise ArgumentError, 'You must specify the key to encrypt new values!' if type == 'SecureString' && key.nil?
      # new parameter. we need the key!
      parameter.key_id = key
      parameter
    end

    def validate_parameter_type(type)
      return type if SSM_PARAMETER_TYPES.include?(type)
      raise MalformattedArgumentError, "Parameter type must be one of #{SSM_PARAMETER_TYPES.join(', ')}"
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
