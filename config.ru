# frozen_string_literal: true

require 'sinatra'
require 'oauth'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require './lib/connect'
require './lib/main'
require './lib/response_parser'
require './lib/secure_client'
run Main
