module Msg
  module Receivers
    def self.included(base)
      base.send :include, MsgClassMethods
    end
  end
  
  module MsgClassMethods
    def receives_messages?
      false
    end

    def receives_messages
      return if receives_messages?
      has_many :envelopes, :as => :receiver, :class_name => "Msg::Envelope"
      
      class_eval {
        extend Msg::ReceiverClassMethods
        include Msg::ReceiverInstanceMethods
      }
      
      Msg.receiving_classes.push(self)
    end
  end
  
  module ReceiverClassMethods
    def receives_messages?
      true
    end
  end

  module ReceiverInstanceMethods

    def unopened_envelopes
      envelopes.unopened
    end

    def opened_envelopes
      envelopes.opened
    end

  end
end
