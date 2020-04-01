# frozen_string_literal: true

require 'smps/version'
require 'smps/parameter'
require 'aws-sdk-ssm'

module SmPs
  # Presents a client interface with parameter parsing to aws ssm
  # Allows querying and writing Paramstore parameters.
  class Client
    def initialize(options = {})
      @credentials = options[:credentials]
      @parameters = {}
    end

    # Creates (if needed) and returns the ssm_client.
    def ssm_client
      @ssm_client ||= initialize_ssm_client
    end

    # Creates a new SmPs::Parameter from the given options hash.
    def parameter(options)
      name = options.fetch(:name)
      type = options[:type]
      key_id = options[:key_id]
      unless @parameters.key?(name)
        @parameters[name] = SmPs::Parameter.new(
          ssm: ssm_client,
          name: name, type: type, key_id: key_id
        )
      end
      @parameters[name]
    end

    # Creates a list of all parameters filtered by path.
    def parameters_by_path(options)
      @parameters_by_path_list = []
      next_token = nil
      while (params = get_parameters_by_path_with_token(options, next_token))
        store_parameters params
        next_token = params.next_token
        break if next_token.nil? || next_token.empty?
      end
      parameters_result_hash options.fetch(:path), @parameters_by_path_list
    end

    protected

    def parameters_result_hash(path, list)
      path = "#{path}/" unless path.end_with?('/')
      # .to_h is not available in jruby (the puppetserver ruby version)
      # list.map { |p| [p.name.gsub(/#{Regexp.escape(path)}/, ''), p.value] }.to_h
      arr = list.map { |p| [p.name.gsub(/#{Regexp.escape(path)}/, ''), p.value] }
      Hash[arr]
    end

    # Get a parameter list by path using the next_token (if provided)
    def get_parameters_by_path_with_token(options, next_token = nil)
      ssm_client.get_parameters_by_path(
        path: options.fetch(:path),
        recursive: options[:recursive],
        with_decryption: options.fetch(:decrypt, true),
        next_token: next_token
      )
    end

    private

    def store_parameters(params)
      return if params.nil?
      params.parameters.each do |parameter|
        @parameters[parameter.name] = SmPs::Parameter.new(
          ssm: ssm_client, fetch: false,
          name: parameter.name, value: parameter.value, type: parameter.type
        )
        @parameters_by_path_list << @parameters[parameter.name]
      end
    end

    # def info
    #   describe_parameters
    # end
    #
    # def parameter_list
    #   get_parameters
    # end
    #
    # def by_path
    #   get_parameters_by_path
    # end

    def initialize_ssm_client
      if @credentials.nil?
        Aws::SSM::Client.new
      else
        Aws::SSM::Client.new(credentials: @credentials)
      end
    end
  end
end
