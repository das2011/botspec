# Botspec

Making specs for your bot that can be run in your build pipeline.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'botspec'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install botspec

## Usage

You will need to have AWS credentials set up. A dot file or env vars normally apply. E.g.
* AWS_REGION
* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Running a command
To install run 
```thor install lib/cli.thor --as botspec --force
```
Then you can run 

```
thor cli:verify -f specs/simple_dialog.yaml
```


## Publishing
To publish run
```
rake release[remote]
```

Should create a changelog record

## Docker
You can run the command with:
```
docker run -e AWS_REGION -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -v `pwd`:/app/bot -it botspec thor cli:verify -f specs/simple_dialog.yaml
```

Assuming you are in your project root directory and your specs are in the corresponding specs folder



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/botspec. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Botspec project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/botspec/blob/master/CODE_OF_CONDUCT.md).
