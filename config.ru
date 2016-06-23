require "sinatra"
require "oauth"
require "sass/plugin/rack"

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require "./lib/constants"
require "./lib/net_http"
require "./lib/main"
run Main
