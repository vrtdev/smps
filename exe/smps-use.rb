#!/usr/bin/env ruby

require 'awssession'
require 'smps'

require 'aws_config'
require 'pp'

profile_name = 'vrt-dpc-sandbox-admin'
profile = AWSConfig[profile_name]
profile['name'] = profile_name

awssession = AwsSession.new(profile: profile)
awssession.start

smps = SmPs.new(credentials: awssession.credentials)
# param = smps.parameter(name: 'abc')
param_abc = smps.parameter('abc')
puts param_abc.to_s
# puts "#{param_abc}"
param_abc.write!('xyz')
puts param_abc.to_s

param_z = smps.parameter('/Zipkid/test1')
puts param_z.to_s
