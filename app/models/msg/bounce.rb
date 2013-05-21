module Msg
  class Bounce < ActiveRecord::Base
    attr_accessible :email, :envelope, :bounce_type, :bounce_subtype, :raw_message, :reporter, :diagnostic, :status
    belongs_to :envelope

    validates :email, :presence => true
    
    scope :fatal, where(:bounce_type => "Permanent")
    scope :transient, where(:bounce_type => "Transient")
    
    def fatal?
      bounce_type == 'Permanent'
    end

    def transient?
      bounce_type == 'Transient'
    end
    
    # This is so far just a quick and slightly dirty console call to turn an email message into a bounce record.
    # With a bit more header-processing we should be able to record type and subtype.
    def self.from(email, message="")
      create(:email => email, :raw_message => message)
    end
    
  end
end
