module Msg
  class MsgMailer < ActionMailer::Base
    default from: Msg.default_from, :bcc => Msg.email_bcc
    layout Msg.email_layout

    # we send all messages through SES and use SNS to notify of bounces, so all the 
    # return-path and VERP and other gubbins that we would normally need can be omitted
    #
    def message_in_envelope(envelope)
      headers['Message-ID'] = envelope.email_id
      mail({
        :to => %{"#{receiver.name}" <#{receiver.email}>}, 
        :from => envelope.from_address, 
        :subject => envelope.subject, 
        :body => envelope.contents
      })
    end
    
  end
end
