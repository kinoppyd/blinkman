# Blinkman

Blinkman is DSL for [Blink(1)](https://blink1.thingm.com/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blinkman'
```

Default Blinkman uses commandline interface. If you want to connect other services, add adapter plugin for your Gemfile.
ex.

```ruby
gem 'blinkman-slack'
```

And then execute:

    $ bundle install


## Usage

Write ruby script file like this:

```ruby
require 'blinkman'

bot = Blinkman::Bot.new do
  blink red 2.times, during(250), when_if { message.body == 'hello' }
end

bot.listen
```

and execute:

    $ bundle exec ruby example.rb

This example uses commandline adapter (default adapter). Type 'hello' in shell then blink blink(1) red twice.

    $ > hello # blink red

If you want to exit, type 'exit'

    $ > exit


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kinoppyd/blinkman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

