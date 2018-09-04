require 'smps/version'
require 'smps/parameter'
require 'aws-sdk-ssm'

# SmPs class queries and writes Paramstore parameters
module SmPs
  class Client
    def initialize(options = {})
      @credentials = options[:credentials]
      @parameters = {}
    end

    def ssm_client
      @ssm ||= initialize_ssm_client
    end



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

    def parameters_by_path(options)
      @parameters_by_path_list = []
      next_token = nil
      while (params = get_parameters_by_path_with_token(options, next_token))
        store_parameters params
        next_token = params.next_token
        break if next_token.nil? || next_token.empty?
      end
      @parameters_by_path_list
    end

    def get_parameters_by_path_with_token(options, next_token = nil)
      ssm_client.get_parameters_by_path(
        path: options.fetch(:path),
        recursive: options[:recursive],
        with_decryption: options.fetch(:decrypt, true),
        next_token: next_token
      )
    end

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

    private

    def initialize_ssm_client
      if @credentials.nil?
        Aws::SSM::Client.new
      else
        Aws::SSM::Client.new(credentials: @credentials)
      end
    end
  end
end
