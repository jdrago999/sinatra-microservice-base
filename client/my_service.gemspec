$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "my_service/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "my_service"
  s.version     = MyService::VERSION
  s.authors     = ['John Drago']
  s.email       = ['drago@inflection.com']
  s.homepage    = 'https://www.identity.com/'
  s.summary     = "The my_service client gem"
  s.description = "my_service"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.19"

end
