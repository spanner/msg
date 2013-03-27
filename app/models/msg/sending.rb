module Msg
  class Sending < ActiveRecord::Base
    attr_accessible :message_id, :envelopes_attributes

    belongs_to :message
    belongs_to :created_by, :class_name => Msg.user_class

    has_many :envelopes, :dependent => :destroy
    accepts_nested_attributes_for :envelopes

    def self.add_receiving_class(klass, options)
      key = klass.to_s.underscore
      # group= is called from the SendingsController and given the _name_ of a messaging group,
      # we get the designated proc from the class messaging rules, then call it to get an array of receivers
      define_method  :"#{key}_group=" do |name|
        send :"#{key}_receivers=", klass.messaging_rules[name].call
      end
      define_method :"#{key}_receiver_ids=" do |ids|
        send :"#{key}_receivers=", klass.find(ids)
      end
      define_method :"#{key}_receivers=" do |receivers|
        receivers.each do |receiver|
          envelopes.build(:receiver => receiver)
        end
      end
    end

  end
end
