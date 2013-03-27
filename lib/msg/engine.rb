module Msg
  class Engine < ::Rails::Engine
    isolate_namespace Msg

    initializer "msg.integration" do
      ActiveRecord::Base.send :extend, Msg::ActiveRecordClassMethods
      ActiveSupport.on_load :action_controller do
        helper Msg::MsgHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.fixture_replacement :factory_girl
      g.assets false
      g.helper false
    end

  end
end
