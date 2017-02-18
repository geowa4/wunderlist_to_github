# WunderlistToGithub

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/wunderlist_to_github`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wunderlist_to_github'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wunderlist_to_github

## Prerequisites

This project assumes you have a Wunderlist account and are logged in as the user whose tasks you want to migrate to GitHub.

First, you must [create a Wunderlist application](https://developer.wunderlist.com/apps/new).
The values for the form fields don't matter.
After creating the application, you should see a "Client ID" and a "Client Secret"; save the client ID for later use in this program.
There is also a link to "Create Access Token"; click that.
This will reveal an access token to be saved along with the client ID and client secret from before.

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/George Adams IV (geowa4)/wunderlist_to_github.

