# SMPS - System Manager Parameter Store

A command line tool and library to interact with the Amazon System Manager Parameter Store

## Installation

    $ gem install smps

## Usage

### Library

To use this gem in your own tools, add this line to your application's Gemfile:

```ruby
gem 'smps'
```

And then execute:

    $ bundle

### CLI

After installation, 2 executable scripts will be installed: `smps` & `smps-cli`:

- smps: the simple version of this utility.
- smps-cli: The thor cli executable offers a different interface.

#### smps

Run the command with `--help` for more information.

```
smps [OPTION]

    -h, --help:
    show help

    -r, --role <rolename>
    IAM role to use. From ~/.aws/config
    Use this for interactive use on your workstation.

    -p, --param <param_name>
    Parameter name.

    -b --by_path <path>
    Path name

    -v, --value <new_value>
    Value to assign

    -t, --type <type>
    Parameter type.
    One of [String StringList SecureString]

    -k, --key <key_id>
    Key for SecureString encrypting.

    -d, --debug [level]:
    Debug level.
```

#### smps-cli

The smps-cli command is a new cli with more straightforward actions.

Run the command with `help` for more information: `smps-cli help`. For each individual action,
you can also use `smps-cli help <action>`

##### help

```
Commands:
  smps-cli get NAME                    # Get path or path indicated by the name
  smps-cli help [COMMAND]              # Describe available commands or one s...
  smps-cli set NAME VALUE --type=TYPE  # Set the parameter to this value

Options:
  [--role=PROFILE]                 # IAM profile/role to use. From ~/.aws/config
  [--region=REGION]                # Override the aws region
  [--debug=N]                      # AwsSession debug level.
                                   # Default: 0
  [--user-data], [--no-user-data]  # Retrieve the name or path, and the key values from the userdata
```

##### get NAME

```
Usage:
  smps-cli get NAME

Options:
  [--role=PROFILE]                 # IAM profile/role to use. From ~/.aws/config
  [--region=REGION]                # Override the aws region
  [--debug=N]                      # AwsSession debug level.
                                   # Default: 0
  [--user-data], [--no-user-data]  # Retrieve the name or path, and the key values from the userdata

Description:
  Gets a value from the parameter store.
```

##### set NAME VALUE

```
Usage:
  smps-cli set NAME VALUE --type=TYPE

Options:
  --type=TYPE
                                   # Default: String
  [--key=ARN]                      # KMS key for SecureString encryption/decryption
  [--role=PROFILE]                 # IAM profile/role to use. From ~/.aws/config
  [--region=REGION]                # Override the aws region
  [--debug=N]                      # AwsSession debug level.
                                   # Default: 0
  [--user-data], [--no-user-data]  # Retrieve the name or path, and the key values from the userdata

Set the parameter to this value
```

## Development

After checking out the repo, run `./bin/setup` to install dependencies. Then, run `bundle exec rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To test the `smps` utility on your local machine, run `bundle exec smps --help` to see command-line options.

## Contributing

We use git flow in this project. To create your pull request, you can either use the git-flow helper or
manually create a new feature branch and pull request.

1. Fork it ( https://github.com/vrtdev/smps/fork )
2. Clone your forked repository.
3. Create your feature branch (`git checkout -b feature/my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin feature/my-new-feature`)
6. Create a new Pull Request. Remember to make the pull request against the `develop` branch.

Bug reports and pull requests are welcome on GitHub at https://github.com/vrtdev/smps.
