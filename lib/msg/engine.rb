module Msg
  class Engine < ::Rails::Engine
    isolate_namespace Msg
    
    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
      g.fixture_replacement :factory_girl
      g.assets false
      g.helper false
    end
    
    initializer "msg.integration" do
      ActiveRecord::Base.send :include, Msg::Receivers
    end
    
    initializer 'msg.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Msg::MsgHelper
      end
    end
    
  end
end
