module Msg
  class Envelope < ActiveRecord::Base

    belongs_to :sending
    belongs_to :receiver, :polymorphic => true
    has_many :bounces
    
    after_create :send_message
    
    def open!
      update_column(:opened_at, Time.now)
    end
    
  protected
  
    def send_message
      # this is where mailhopper kicks in
      # possibly also roadie
    end

  end
end
