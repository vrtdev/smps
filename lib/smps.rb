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
