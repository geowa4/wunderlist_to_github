# Wunderlist-To-Github

You have tasks in a list in Wunderlist, but
you want them as issues on GitHub.
That's what this does.

Limitations are defined in the Future Work section at the bottom.
If you want to see a change made, please, open an issue or issue a pull request.

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
This will reveal an access token to be saved along with the client ID from before.

With Wunderlist setup, let's move to GitHub.
Start by getting a [personal access token](https://github.com/settings/tokens).
Enter anything you'd like for the "Token description", but
be sure to check the box next to "repo" so that token has the proper permissions.
When finished, click "Generate token", and
save the token along with the Wunderlist items from before.

## Usage

All available commands can be viewed via the `help` command.

    $ wunderlist_to_github help

Before the following commands can be run, those values saved from the Prerequisites section will need to be set as environment variables.
The first option is to export them all.

    $ export WUNDERLIST_CLIENT_ID=12345678901234567890
    $ export WUNDERLIST_ACCESS_TOKEN=123456789012345678901234567890123456789012345678901234567890
    $ export GITHUB_LOGIN=yourlogin
    $ export GITHUB_API_TOKEN=1234567890123456789012345678901234567890

The second option is to store them in a file called .env.

    $ cat .env
    WUNDERLIST_CLIENT_ID=12345678901234567890
    WUNDERLIST_ACCESS_TOKEN=123456789012345678901234567890123456789012345678901234567890
    GITHUB_LOGIN=yourlogin
    GITHUB_API_TOKEN=1234567890123456789012345678901234567890

That approach requires calling the following commands like so.

    $ env $(xargs < .env) wunderlist_to_github command arg0 arg1 arg2

This is how I set environment variables for a given program since others I run later cannot read them.

See all the tasks' titles that will be retrieved for a given list.

    $ wunderlist_to_github tasks WUNDERLISTNAME

Convert tasks into issues.

    $ wunderlist_to_github convert WUNDERLISTNAME GITHUBUSER GITHUBPREPOSITORY

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests.
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and
then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/geowa4/wunderlist_to_github.
Generally, anything with a relevant use case and tests will be accepted.

## Future Work

- [ ] Keep completed state of subtasks; this doesn't seem to be in the gem.
- [ ] Retry on API failure.
- [ ] Skip first n issues (in case of failure).
- [ ] Edit a GitHub issue if reran in case of failure or updates in Wunderlist.
- [ ] Add formatting options.
- [ ] Assign GitHub users based on Wunderlist assignee.
- [ ] Override environment variables with command line options.
