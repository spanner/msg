module Msg
  class Envelope < ActiveRecord::Base

    belongs_to :sending
    belongs_to :receiver, :polymorphic => true
    has_many :bounces

  end
end
