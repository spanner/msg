require "msg/receivers"
require "msg/engine"

module Msg
  mattr_accessor :email_layout, 
                 :group_scopes
  
  class MsgError < StandardError; end
  class EmailInvalid < MsgError; end
  
  class << self

    def email_layout
      @@email_layout ||= "msg/email"
    end

    def group_scopes
      @@group_scopes ||= []
    end
    
    def add_group_scope(scope)
      group_scopes.push(scope)
    end

  end

end
