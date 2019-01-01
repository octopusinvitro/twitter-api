# frozen_string_literal: true

require 'dotenv/load'
require './lib/main'
require 'sass/plugin/rack'

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run Main
