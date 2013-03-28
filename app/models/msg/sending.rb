module Msg
  class Sending < ActiveRecord::Base
    attr_accessible :message_id, :envelopes_attributes

    belongs_to :message
    belongs_to :created_by, :class_name => Msg.user_class
    has_many :envelopes, :dependent => :destroy

    def receivers=(receivers)
      receivers.each do |rec|
        self.envelopes.build(:receiver => rec, :sending => self)
      end
    end

    def statistics
      sent = envelopes.count || 0
      bounced = envelopes.bounced.count || 0
      read = envelopes.opened.count || 0
      unread = sent-read-bounced
      [unread, read, bounced]
    end

    def self.add_receiver_hooks(klass, options)
      key = klass.to_s.underscore

      define_method  :"#{key}_group" do
        self.receiving_group if self.receiving_class == key
      end

      # class_group= is called from the SendingsController and given the _name_ of a messaging group,
      # we get the designated proc from the class messaging rules, then call it to get an array of receivers
      #
      define_method  :"#{key}_group=" do |name|
        self.receiving_class = key
        self.receiving_group = name
        self.receivers = klass.messaging_groups[name.to_sym].call unless name == 'selected'
      end
      attr_accessible :"#{key}_group"
      
      define_method  :"#{key}_receiver_ids" do
        self.envelopes.map(&:receiver_id) if self.receiving_class == key
      end
      attr_accessible :"#{key}_receiver_ids"

      # class_receiver_ids= is called from the SendingsController and given a list of receiver ids of this class.
      # they are instantiated and passed to receivers=
      #
      define_method :"#{key}_receiver_ids=" do |ids|
        self.receivers = klass.find(ids)
      end
    end

  end
end
