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
                 desc: 'IAM profile/role to use. From ~/.aws/config',
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

    class_option 'user-data',
                 desc: 'Retrieve the name or path, and the key values from the userdata',
                 default: false,
                 type: :boolean

    class_option 'user-data-type',
                 desc: 'Set (force) the user-data type (json or yaml).',
                 default: :auto,
                 hide: true

    class_option 'user-data-source',
                 banner: 'URI',
                 hide: true,
                 default: DEFAULT_USERDATA_URI,
                 desc: 'Override userdata retrieval by using this URI in stead.',
                 long_desc: <<-LONGDESC
                     The provided value must be a valid and parseable URI.
                     By default, if the scheme is not http or https, we will
                     presume it is a local file.
                 LONGDESC

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
      parameter.key_id = retrieve_option(key)
      parameter
    end

    def validate_parameter_type(type)
      return type if SSM_PARAMETER_TYPES.include?(type)
      raise MalformattedArgumentError, "Parameter type must be one of #{SSM_PARAMETER_TYPES.join(', ')}"
    end

    private

    def get_parameter(name)
      smps.parameter(name: retrieve_option(name), type: options['type'], fetch: true)
    end

    # This will either return the provided option or look
    # in the user-data (if it has been enabled) for a key with the provided name and use
    # that value instead.
    def retrieve_option(name)
      if options['user-data']
        retrieve_from_userdata(name, options['user-data-type'], options['user-data-source'])
      else
        options[name] || name
      end
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
