#!/usr/bin/env ruby
# frozen_string_literal: true

require 'awssession'
require 'smps'

require 'aws_config'
require 'awesome_print'

profile_name = ARGV[0]
profile = AWSConfig[profile_name]
profile['name'] = profile_name

awssession = AwsSession.new(profile: profile)
awssession.start

smps = SmPs::Client.new(credentials: awssession.credentials)

puts '1'
pl = smps.parameters_by_path(path: '/aem/dev/aem--author/packages')
puts '2'
# ap pl
pl.each do |p|
  puts ' ---- '
  ap p
  puts p.name
  ap p.value
end

# exit

# param = smps.parameter(name: 'abc')
param_abc = smps.parameter(name: 'abc')
puts param_abc.to_s
# puts "#{param_abc}"

param_abc.write!('xyz')
puts param_abc.to_s
# OR
param_abc.value = 'def'
param_abc.write!
puts param_abc.to_s

param_z = smps.parameter(name: '/Zipkid/test1')
puts param_z.to_s
