module Msg
  class Sending < ActiveRecord::Base
    belongs_to :message
    has_many :envelopes
    belongs_to :created_by, :foreign_class => Msg.user_class
  end
end
