#!/usr/bin/env ruby

require 'smps'

smps = SmPs.new
param_abc = smps.parameter(name: 'abc')
puts param_abc.to_s

param_abc.write!('xyz')
puts param_abc.to_s

param_abc.write!('Another value.')
puts param_abc.to_s

param_z = smps.parameter(name: '/Zipkid/test1')
puts param_z.to_s
