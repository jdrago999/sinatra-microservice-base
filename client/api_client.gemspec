$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "api_client"
require "api_client/version"
require "api_client/wrapper"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "api_client"
  s.version     = ApiClient::VERSION
  s.authors     = ['John Drago']
  s.email       = ['drago@inflection.com']
  s.homepage    = 'https://www.identity.com/'
  s.summary     = "The api_client gem"
  s.description = "api_client"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.11"

end
