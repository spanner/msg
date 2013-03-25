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
  s.summary     = "Makes your email more flavoursome."
  s.description = "Msg is a general-purpose messaging engine for rails 3 apps. Use it to compose, revise, send and resend messages to selected or generated groups of user-like objects. It uses a simple mustache-based template system and brings your devise email templates into the database so that they too are editable and resendable."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"

  s.add_runtime_dependency 'dynamic_form'
  s.add_runtime_dependency 'haml'
  s.add_runtime_dependency 'kaminari'

  # Sending mail
  s.add_runtime_dependency 'roadie'
  s.add_runtime_dependency 'mustache'
  s.add_runtime_dependency 'aws-ses'
  
  # Confirming SNS subscriptions
  s.add_runtime_dependency 'httpclient'

  # Testing
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'capybara'
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  
end
