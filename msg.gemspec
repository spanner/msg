$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "msg/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "msg"
  s.version     = Msg::VERSION
  s.authors     = ["William Ross"]
  s.email       = ["will@spanner.org"]
  s.homepage    = "https://github.com/spanner/msg"
  s.summary     = "Make your email flavoursome."
  s.description = "Msg is a general-purpose messaging engine for rails apps. Use it to compose, revise, send and resend messages to selected groups of user-like objects. It uses a simple mustache-based template system and requires a mandrill API key."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.2"

  # Sending mail
  s.add_runtime_dependency 'mustache'
  s.add_runtime_dependency 'mandrill-api'

  # Testing
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'capybara'
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  
end
