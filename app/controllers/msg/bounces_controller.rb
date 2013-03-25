module Msg
  class BouncesController < Msg::EngineController
    respond_to :json
    
    # this is pinged from Amazon SNS with a JSON bounce package, if I've got it vaguely right:
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
    def create
      @bounce.update_attributes(params[:bounce])
      respond_with @bounce
    end
    
  protected
  
    def build_bounce
      @bounce = Msg::Bounce.new(params[:bounce])
    end
  
  end
end
