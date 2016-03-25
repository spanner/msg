require 'mandrill'

module Msg
  class MandrillSendingJob < ActiveJob::Base
    queue_as :default

    def perform(envelope)
      mandrill = Mandrill::API.new Msg.mandrill_api_key
      results = mandrill.messages.send(envelope.for_mandrill)
      response = results.first
      message.mandrill_id = response['_id']
      if response['status'] == "rejected"
        message.bounced = true
        message.rejection_message = response['reject_reason']
      end
      message.sent_at = Time.now
      message.save
    end

  end
end