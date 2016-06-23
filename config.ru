require "sinatra"
require "oauth"
require "sass/plugin/rack"

Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

require "./lib/constants"
require "./lib/messages"
require "./lib/net_http"
require "./lib/net_http_get"
require "./lib/connect"
require "./lib/parser"
require "./lib/main"
run Main
