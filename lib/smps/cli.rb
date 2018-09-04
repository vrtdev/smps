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
      # @TODO: implement
      return name
    end
  end
end
