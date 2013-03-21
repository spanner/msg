module Msg
  class Bounce < ActiveRecord::Base
    attr_accessible :envelope_id, :status, :error, :raw_message
    belongs_to :envelope
  end
end
