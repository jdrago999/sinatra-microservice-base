
require './app'

use Rack::ShowExceptions

run MyService::App.new
