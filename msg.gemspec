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
  s.summary     = "Makes your transactional and promotional email more flavoursome."
  s.description = "MSG is a general-purpose messaging engine for rails 3 apps. Use it to compose, revise, send and resend messages to selected or generated groups of user-like objects."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "jquery-rails"
  s.add_dependency 'dynamic_form'
  s.add_dependency 'haml'
  s.add_dependency 'kaminari'

  # Sending mail
  s.add_dependency 'roadie'
  s.add_dependency 'daemons'
  s.add_dependency 'delayed_job_active_record'
  s.add_dependency 'delayed_mailhopper'
  
  # Receiving mail
  s.add_dependency 'mailman'

  # Testing
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency 'cucumber-rails'
  
end
