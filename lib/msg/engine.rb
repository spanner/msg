module Msg
  class Engine < ::Rails::Engine
    isolate_namespace Msg
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.fixture_replacement :factory_girl
    end
  end
end
