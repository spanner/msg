module Msg
  class Sending < ActiveRecord::Base
    attr_accessible :message_id, :envelopes_attributes

    belongs_to :message
    belongs_to :created_by, :foreign_class => Msg.user_class
    has_many :envelopes
    accepts_nested_attributes_for :envelopes
  end
end
