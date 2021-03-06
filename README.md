[![Build Status](https://travis-ci.org/octopusinvitro/twitter-api.svg?branch=master)](https://travis-ci.org/octopusinvitro/twitter-api)
[![build status](https://gitlab.com/octopusinvitro/twitter-api/badges/master/build.svg)](https://gitlab.com/octopusinvitro/twitter-api/commits/master)
[![Coverage Status](https://coveralls.io/repos/github/octopusinvitro/twitter-api/badge.svg?branch=master)](https://coveralls.io/github/octopusinvitro/twitter-api?branch=master)
[![Maintainability](https://codeclimate.com/github/octopusinvitro/twitter-api/badges/gpa.svg)](https://codeclimate.com/github/octopusinvitro/twitter-api)
[![Dependency status](https://badges.depfu.com/badges/a5f9aa0eb83998a1a81f7b1298a0b4f8/overview.svg)](https://depfu.com/github/octopusinvitro/ruby-scafold?project=Bundler)


# Readme

A project to play with Sinatra and the Twitter API.


## How to use this project

This is a Ruby project.
You will need to tell your favourite Ruby version manager to set your local Ruby version to the one specified in the `.ruby-version` file.

For example, if you are using [rbenv](https://cbednarski.com/articles/installing-ruby/):

1. Install the right Ruby version:
```bash
$ rbenv install < VERSION >
$ rbenv rehash
```
1. Move to the root directory of this project and type:
```bash
$ rbenv local < VERSION >
$ ruby -v
```

You will also need to install the `bundler` gem, which will allow you to install the rest of the dependencies listed in the `Gemfile` file of this project.

```bash
$ gem install bundler
$ rbenv rehash
```


### Folder structure

* `bin `: Executables
* `lib `: Sources
* `spec`: Tests


### To initialise the project

```bash
$ bundle install
```

Go to https://developer.twitter.com/en/apps, create an app and take note of your credentials. Make sure the permissions are set to "Read and write". Then copy `.env_example` to `.env` and replace with your app's credentials.

### To run the tests

```bash
$ bundle exec rake
```


### To run the app

Make sure that the `bin/app` file has execution permissions:

```bash
$ chmod +x bin/app
```

Then just type:

```bash
$ bin/app
```

Open your browser and go to http://localhost:4567/


### Another way of running it

Update the `config.ru` file, then type

```bash
$ rackup
```

Open your browser and go to http://localhost:9292/

### Useful links

* [Testing external APIs in Ruby](http://asquera.de/blog/2015-03-30/testing-external-apis-in-ruby/)
* [Securing your webhooks](https://developer.github.com/webhooks/securing/)
* [Twitter API - reference](https://developer.twitter.com/en/docs/api-reference-index)
* [Twitter API - verify credentials](https://developer.twitter.com/en/docs/accounts-and-users/manage-account-settings/api-reference/get-account-verify_credentials)
* [Twitter API - show user](https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/api-reference/get-users-show)
* [Twitter API - show tweet](https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/get-statuses-show-id)
* [Twitter API - user timeline](https://developer.twitter.com/en/docs/tweets/timelines/api-reference/get-statuses-user_timeline)
* [Twitter API - post tweet](https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update)


## License

[![License](https://img.shields.io/badge/gnu-license-green.svg?style=flat)](https://opensource.org/licenses/GPL-2.0)
GNU License
