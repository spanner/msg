require "msg/receivers"
require "msg/engine"

module Msg
  mattr_accessor :user_class,
                 :layout,
                 :email_layout, 
                 :group_scopes,
                 :receiving_classes
  
  class MsgError < StandardError; end
  class EmailInvalid < MsgError; end
  
  class << self

    def layout
      @@user_class ||= "User"
    end

    def layout
      @@email_layout ||= "msg/default"
    end

    def email_layout
      @@email_layout ||= "msg/email"
    end

    def group_scopes
      @@group_scopes ||= []
    end
    
    def add_group_scope(scope)
      group_scopes.push(scope)
    end

    def receiving_classes
      @@receiving_classes ||= []
    end

  end
end
