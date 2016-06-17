# SEGA - Self-Extracting Gem Archive

This is a tool that will help you create a self-extracting gem (cli) archive.

Similar in concept to [traveling-ruby](https://github.com/phusion/traveling-ruby) or [orca](https://github.com/larsch/ocra) or [releasy](https://github.com/Spooner/releasy) but it makes some basic assumptions to simplify the package.

For example:

```
# create new gem
# create exe/<whatever>
# git add -A

$ $EDITOR Gemfile

## Add these lines:

require 'sega/rake_task'

Sega::RakeTask.new() do |t|
  t.bundler_version = '1.10.6' # uses gem version comparison operators
  t.ruby_version = '~> 2.3.0' # uses gem version comparison operators
end


$ bundle install
Resolving dependencies...
Using rake 10.5.0
Using bundler 1.10.6
Using hello-sega 0.1.0 from source at .
Using sega 0.1.2
Updating files in vendor/cache
Bundle complete! 4 Gemfile dependencies, 4 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.

$ bundle exec rake sega:package
Using rake 10.5.0
Using bundler 1.10.6
Using hello-sega 0.1.0 from source at .
Using sega 0.1.2
Updating files in vendor/cache
Bundle complete! 4 Gemfile dependencies, 4 gems now installed.
Use `bundle show [gemname]` to see where a bundled gem is installed.
Updating files in vendor/cache
Created Self-Extracting Gem Archive: hello-sega.run

$ ./hello-sega.run
created target shim: /usr/local/bin/hello-sega

$ hello-sega
Hello SEGA!

```


Assumes:
* target machine has ruby (preferably [rbenv](https://github.com/rbenv/rbenv))
* target machine has [bundler](http://bundler.io/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sega'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sega

## Usage

_Only tested on linux & mac right now_

### Configure

Add to your Rakefile:

```

require 'sega/rake_task'

Sega::RakeTask.new() do |t|
  t.bundler_version = '1.10.6' # uses gem version comparison operators
  t.ruby_version = '~> 2.3.0' # uses gem version comparison operators
end

```

### Build

Create the self-extracting gem archive:

```
bundle exec rake sega:package
```

Will generate: ```<project name>.run```


### Install


```
./<project name>.run <optional: target directory> <optional: target binstub directory>
```

Default target directory:  ```/usr/local/<project name/```

Default target binstub directory:  ```/usr/local/bin/```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdamick/sega.
