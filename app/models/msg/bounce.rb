module Msg
  class Bounce < ActiveRecord::Base
    attr_accessible :envelope, :bounce_type, :bounce_subtype, :raw_message, :reporter
    belongs_to :envelope
    validates :envelope, :presence => true
    
    scope :fatal, where(:bounce_type => "Permanent")
    scope :transient, where(:bounce_type => "Transient")
    
    def fatal?
      bounce_type == 'Permanent'
    end

    def transient?
      bounce_type == 'Transient'
    end
    
  end
end
