[![Build Status](https://travis-ci.org/octopusinvitro/twitter-api.svg?branch=master)](https://travis-ci.org/octopusinvitro/twitter-api)
[![build status](https://gitlab.com/me-stevens/twitter-api/badges/master/build.svg)](https://gitlab.com/me-stevens/twitter-api/commits/master)
[![Coverage Status](https://coveralls.io/repos/github/octopusinvitro/twitter-api/badge.svg?branch=master)](https://coveralls.io/github/octopusinvitro/twitter-api?branch=master)
[![Code Climate](https://codeclimate.com/github/octopusinvitro/twitter-api/badges/gpa.svg)](https://codeclimate.com/github/octopusinvitro/twitter-api)

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
$ bundle exec rake
```


### To run the tests

```bash
$ bundle exec rspec --color
```


### Another way of running them

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


## License

[![License](https://img.shields.io/badge/gnu-license-green.svg?style=flat)](https://opensource.org/licenses/GPL-2.0)
GNU License
