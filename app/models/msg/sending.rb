module Msg
  class Sending < ActiveRecord::Base
    belongs_to :message
    belongs_to :created_by, :foreign_class => Msg.user_class
    has_many :envelopes

    def receiver_ids=(ids)

    end
    
  end
end
