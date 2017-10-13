require 'smps/version'
require 'smps/parameter'
require 'aws-sdk-ssm'

# SmPs class queries and writes Paramstore parameters
class SmPs
  def initialize(options = {})
    @credentials = options[:credentials]
    @parameters = {}
  end

  def ssm_client
    @ssm || @ssm = if @credentials.nil?
                     Aws::SSM::Client.new
                   else
                     Aws::SSM::Client.new(credentials: @credentials)
                   end
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
    path = options.fetch(:path)
    recursive = options[:recursive]
    decrypt = options[:decrypt] || true
    params = ssm_client.get_parameters_by_path(
      path: path,
      recursive: recursive,
      with_decryption: decrypt
    )
    store_parameters params
  end

  def store_parameters(params)
    return if params.nil?
    list = []
    params.parameters.each do |parameter|
      @parameters[parameter.name] = SmPs::Parameter.new(
        ssm: ssm_client, fetch: false,
        name: parameter.name, value: parameter.value, type: parameter.type
      )
      list << @parameters[parameter.name]
    end
    list
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
end
