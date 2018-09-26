# frozen_string_literal: true

require 'smps/version'
require 'smps/client'
require 'smps/aws'
require 'smps/cli'

# Dummy module. Includes all required classes/libs
module SmPs
  def self.new(*args)
    Client.new(*args)
  end
end
