require 'open-uri'

module Msg
  class BouncesController < Msg::EngineController
    respond_to :json

    # this is pinged from Amazon SNS with a JSON body something like this:
    #
    # {
    #     "notificationType":"Bounce",
    #     "bounce":{
    #        "bounceType":"Permanent",
    #        "reportingMTA":"dns; email.example.com",
    #        "bouncedRecipients":[
    #           {
    #              "emailAddress":"username@example.com",
    #              "status":"5.1.1",
    #              "action":"failed",
    #              "diagnosticCode":"smtp; 550 5.1.1 <username@example.com>... User"
    #           }
    #        ],
    #        "bounceSubType":"General",
    #        "timestamp":"2012-06-19T01:07:52.000Z",
    #        "feedbackId":"00000138111222aa-33322211-cccc-cccc-cccc-ddddaaaa068a-000000"
    #     },
    #     "mail":{
    #        "timestamp":"2012-06-19T01:05:45.000Z",
    #        "source":"sender@example.com",
    #        "messageId":"00000138111222aa-33322211-cccc-cccc-cccc-ddddaaaa0680-000000",
    #        "destination":[
    #           "username@example.com"
    #        ]
    #     }
    #  }
    #
    #
    # When the subscription is first set up they will also POST us a SubscriptionConfirmation,
    # upon which we have to GET the given url to confirm that we can follow orders.
    #
    def create
      if request.headers['x-amz-sns-message-type'] == 'SubscriptionConfirmation'
        response = HTTParty.get(params['SubscribeURL'])
        head :ok

      else
        mail = params['Message']['mail']
        bounce = params['Message']['bounce']
        if envelope = Msg::Envelope.find_by_email_id(mail['messageId'])
          envelope.bounces.create({
            :bounce_type => bounce['bounceType'],
            :bounce_subtype => bounce['bounceSubType'],
            :reporter => bounce['reportingMTA'],
            :raw_message => JSON.dump(bounce)
          })
        end
        head :ok
      end
    end

  protected

    def build_bounce
      @bounce = Msg::Bounce.new(params[:bounce])
    end

  end
end
