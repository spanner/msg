require 'open-uri'

module Msg
  class BouncesController < ::ApplicationController
    respond_to :json
    
    before_filter :read_json_body

    # When the subscription is first set up they will also POST us a SubscriptionConfirmation,
    # upon which we have to GET the given url to confirm that we are able to follow orders.
    #
    def create
      data = ActiveSupport::JSON.decode(request.body)
      
      if request.env['x-amz-sns-message-type'] == 'SubscriptionConfirmation'
        response = HTTParty.get(data['SubscribeURL'])
        head :ok

      else
        mail_data = data['mail']
        bounce_data = data['bounce']
        recipients = [bounce_data['bouncedRecipients']].flatten
        envelope = Msg::Envelope.find_by_email_id(mail_data['messageId'])
        recipients.each do |recipient_data|
          Msg::Bounce.create({
            :envelope => envelope,
            :bounce_type => bounce_data['bounceType'],
            :bounce_subtype => bounce_data['bounceSubType'],
            :reporter => bounce_data['reportingMTA'],
            :email => recipient_data['emailAddress'],
            :status => recipient_data['status'],
            :diagnostic => recipient_data['diagnosticCode'],
            :raw_message => JSON.dump(bounce_data)
          })
        end
        head :ok
      end
    end

  protected
    
    # Amazon sends its SNS notifications as json data with a text/plain content-type, which 
    # rails really hates. Here we read the json body if it hasn't already been read.
    #
    def read_json_body
    
    end
  
  end
end
