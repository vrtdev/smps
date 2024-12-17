# SMPS - System Manager Parameter Store

A command line tool and library to interact with the Amazon System Manager Parameter Store

## Installation

```bash
gem install smps
```

## Usage

### Library

To use this gem in your own tools, add this line to your application's Gemfile:

```ruby
gem 'smps'
```

And then execute:

```bash
bundle
```

### CLI

After installation the `smps` executable will be available.

#### smps

Run the command with `--help` for more information.

```text
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

## Development

After checking out the repo, install dependencies.

```bash
./bin/setup
```

 Then run the tests.

 ```bash
bundle exec rake spec
```

To install this gem onto your local machine.

```bash
bundle exec rake install
```

To create a package that can be installed on a different machine.

```bash
bundle exec rake build
```

This will create a `.gem` file in the `pkg` directory.

To release a new version, update the version number in `version.rb` and then run

```bash
bundle exec rake release
git push --tags
gem push pkg/smps-<version>.gem
```

This will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

To test the `smps` utility on your local machine, run the command below to see command-line options.

```bash
bundle exec smps --help
```

## Contributing

We use git flow in this project. To create your pull request, you can either use the git-flow helper or
manually create a new feature branch and pull request.

1. Fork it ( <https://github.com/vrtdev/smps/fork> )
2. Clone your forked repository.
3. Create your feature branch (`git checkout -b feature/my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin feature/my-new-feature`)
6. Create a new Pull Request. Remember to make the pull request against the `develop` branch.

Bug reports and pull requests are welcome on GitHub at <https://github.com/vrtdev/smps>.
