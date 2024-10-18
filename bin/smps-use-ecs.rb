#!/usr/bin/env ruby
# frozen_string_literal: true

require 'smps'

REGION = ARGV[0]
ACCOUNT_ID = ARGV[1]
ROLE = ARGV[2]

def role_credentials(account_id = nil)
    role_arn = "arn:aws:iam::#{ACCOUNT_ID}:role/#{ROLE}"
    sts_client = Aws::STS::Client.new(region: REGION)
    credentials = sts_client.assume_role(duration_seconds: 3_600, role_arn: role_arn, role_session_name: "puppetserver_smps_query-#{Time.now.utc.iso8601.tr!('-:', '_')}")
    Aws::Credentials.new(credentials.credentials.access_key_id, credentials.credentials.secret_access_key, credentials.credentials.session_token)
end

Aws.config.update(region: region)
smps = SmPs::Client.new(credentials: role_credentials())

param_z = smps.parameter(name: '/Zipkid/test1')
puts param_z.to_s
