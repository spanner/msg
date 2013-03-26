module Msg
  class Sending < ActiveRecord::Base
    attr_accessible :message_id, :envelopes_attributes

    belongs_to :message
    belongs_to :created_by, :class_name => Msg.user_class

    has_many :envelopes, :dependent => :destroy
    accepts_nested_attributes_for :envelopes

  end
end
