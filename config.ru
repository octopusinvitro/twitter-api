require "sinatra"
require "sass/plugin/rack"

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require "./lib/main"
run Main
