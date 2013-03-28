# Msg::Receivers is for inclusion into ActiveRecord::Base...

module Msg
  module Receivers
    def self.included(base)
      base.extend ActiveRecordClassMethods
    end
  end
  
  module ActiveRecordClassMethods
    # +receives_messages+ ...
    
    def receives_messages(options={})
      include ReceiverInstanceMethods
      has_many :envelopes, :as => :receiver, :class_name => "Msg::Envelope"
      Msg.add_receiving_class(self, options)
    end
    
    # Messaging groups are usually defined by passing a :groups parameter to `receives_messages`, 
    # but you can also override the messaging_groups methods if that's easier.
    #
    def messaging_groups
      Thread.current["messaging_groups_#{self.to_s.underscore}"]  ||= []
      # @messaging_groups ||= []
    end
    
    # Messaging groups are always held as a hash of name => lambda { retrieval action }, and in a complex
    # case they can be passed in that form. If all the groups correspond to scopes on the receiving class,
    # you can alternatively supply a list of scope names. It will be expanded to simple lambdas here.
    #
    #   receives_messages :groups => [:scope_name, :other_scope_name]
    #
    
    def messaging_groups=(groups)
      if groups.is_a?(Array)
        groups = groups.each_with_object({}) do |grp, hash|
          hash[grp] = lambda { self.send grp }
        end
      end
      Thread.current["messaging_groups_#{self.to_s.underscore}"] = groups
    end
    
    def messaging_group(name)
      if definition = messaging_groups(name)
        definition.call()
      else
        self.send name
      end
    end
    
  end
  
  module ReceiverInstanceMethods
    
    
    
  end
end






