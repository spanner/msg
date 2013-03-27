# Msg::Receivers is for inclusion into ActiveRecord::Base...

module Msg
  module Receivers
    def self.included(base)
      base.extend ActiveRecordClassMethods
    end
  end
  
  module ActiveRecordClassMethods
    # +receives_messages+ ...
    
    def receives_messages(options)
      include ReceiverInstanceMethods
      has_many :envelopes, :as => :receiver, :class_name => "Msg::Envelope"
      Msg.add_receiving_class(self, options)
    end
    
    
    # Messaging groups are usually defined by passing a :groups parameter to `receives_messages`, 
    # but you can also override the messaging_groups methods if that's easier.
    #
    def messaging_groups
      @messaging_groups ||= []
    end
    
    def messaging_groups=(groups)
      @messaging_groups = groups
    end
    
  end
  
  module ReceiverInstanceMethods
    
    
    
  end
end






