require 'spec_helper'

module Msg
  describe BouncesController do

    before :each do
      @routes = Msg::Engine.routes
      sign_in_admin
    end

    it "should respond positively to an SNS confirmation test"

    describe "POST #create" do
      it "should file a new bounce" do
        envelope = FactoryGirl.create(:valid_envelope)
        ap envelope
        bounce = {
          "notificationType" => "Bounce",
          "bounce" => {
            "bounceType" => "Permanent",
            "reportingMTA" => "dns; email.example.com",
            "bouncedRecipients" => [
              {
                "emailAddress" => "username@example.com",
                "status" => "5.1.1",
                "action" => "failed",
                "diagnosticCode" => "smtp; 550 5.1.1 <username@example.com>... User"
              }
            ],
            "bounceSubType" => "General",
            "timestamp" => "2012-06-19T01:07:52.000Z",
            "feedbackId" => "00000138111222aa-33322211-cccc-cccc-cccc-ddddaaaa068a-000000"
          },
          "mail" => {
            "timestamp" => "2012-06-19T01:05:45.000Z",
            "source" => "sender@example.com",
            "messageId" => envelope.email_id,
            "destination" =>  [
              "username@example.com"
            ]
          }
        }
        expect {
          post :create, { "Message" => bounce }
        }.to change(Msg::Bounce, :count).by(1)
      end
    end
  end
end
