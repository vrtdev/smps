require 'smps/version'
require 'smps/parameter'
require 'aws-sdk-ssm'

class SmPs
  def initialize(options)
    @credentials = options[:credentials]
    @parameters = {}
  end

  def ssm_client
    @ssm || @ssm = Aws::SSM::Client.new(credentials: @credentials)
  end

  def parameter(name)
    unless @parameters.key?(name)
      @parameters[name] = SmPs::Parameter.new(ssm: ssm_client, name: name)
    end
    @parameters[name]
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