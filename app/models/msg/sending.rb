module Msg
  class Sending < ActiveRecord::Base
    attr_accessible :message_id, :envelopes_attributes

    belongs_to :message
    belongs_to :created_by, :class_name => Msg.user_class

    has_many :envelopes, :dependent => :destroy
    accepts_nested_attributes_for :envelopes

    def self.add_receiving_class(klass, options)
      key = klass.to_s.underscore
      define_method  :"#{key}_groups=" do |scope_name|
        send :"#{key}_receiver_ids=", klass.send(scope_name.to_sym)
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
