module Msg
  class Bounce < ActiveRecord::Base
    attr_accessible :envelope_id, :status, :error, :raw_message,
    belongs_to :receiver
    before_save :read_headers
    validates :raw_message, :presence => true
    
    # theoretically:
    #
    # def self.from(email)
    #   if email.bounced?
    #     envelope = Msg::Envelope.find_by_message_id(email.original_message_id)
    #     self.create({
    #       :raw_message => email.to_s,
    #       :body => email.body.decoded,
    #       :subject => email.subject,
    #       :error => email.error_status,
    #       :problem => email.diagnostic_code,
    #       :email => email.final_recipient,
    #       :envelope => envelope,
    #     })
    # end
    
  end
end
