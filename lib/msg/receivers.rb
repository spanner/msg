module Msg
  module Receivers
    def self.included(base)
      base.extend MsgClassMethods
    end
  end
  
  module MsgClassMethods

    def receives_messages?
      false
    end

    def receives_messages(options)
      return if receives_messages?
      class_eval {
        extend Msg::ReceiverClassMethods
        include Msg::ReceiverInstanceMethods
      }
      has_many :envelopes, :as => :receiver, :class_name => "Msg::Envelope"
      Msg.add_receiving_class(self, options)
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
