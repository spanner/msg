require 'spec_helper'

module Msg
  describe BouncesController do

    before :each do
      @routes = Msg::Engine.routes
      # sign_in_admin
    end

    describe "Confirming SNS channel subscription" do
      it "should respond positively to an SNS confirmation test" do
        request.env['x-amz-sns-message-type'] = "SubscriptionConfirmation"
        request.env['User-Agent'] = "Amazon Simple Notification Service Agent"
        request.env['RAW_POST_DATA'] = {
          "Type" => "SubscriptionConfirmation",
          "MessageId" => "165545c9-2a5c-472c-8df2-7ff2be2b3b1b",
          "Token" => "2336412f37fb687f5d51e6e241d09c805a5a57b30d712f794cc5f6a988666d92768dd60a747ba6f3beb71854e285d6ad02428b09ceece29417f1f02d609c582afbacc99c583a916b9981dd2728f4ae6fdb82efd087cc3b7849e05798d2d2785c03b0879594eeac82c01f235d0e717736",
          "TopicArn" => "arn:aws:sns:us-east-1:123456789012:MyTopic",
          "Message" => "You have chosen to subscribe to the topic arn:aws:sns:us-east-1:123456789012:MyTopic. To confirm the subscription, visit the SubscribeURL included in this message.",
          "SubscribeURL" => "https://amazonses.com/?Action=ConfirmSubscription&TopicArn=arn:aws:sns:us-east-1:123456789012:MyTopic&Token=2336412f37fb687f5d51e6e241d09c805a5a57b30d712f794cc5f6a988666d92768dd60a747ba6f3beb71854e285d6ad02428b09ceece29417f1f02d609c582afbacc99c583a916b9981dd2728f4ae6fdb82efd087cc3b7849e05798d2d2785c03b0879594eeac82c01f235d0e717736",
          "Timestamp" => "2012-04-26T20:45:04.751Z",
          "SignatureVersion" => "1",
          "Signature" => "EXAMPLEpH+DcEwjAPg8O9mY8dReBSwksfg2S7WKQcikcNKWLQjwu6A4VbeS0QHVCkhRS7fUQvi2egU3N858fiTDN6bkkOxYDVrY0Ad8L10Hs3zH81mtnPk5uvvolIC1CXGu43obcgFxeL3khZl8IKvO61GWB6jI9b5+gLPoBc1Q=",
          "SigningCertURL" => "https://sns.us-east-1.amazonaws.com/SimpleNotificationService-f3ecfb7224c7233fe7bb5f59f96de52f.pem"
        }.to_json
        
        post :create
        response.should be_success
        FakeWeb.should have_requested(:get, "https://amazonses.com/?Action=ConfirmSubscription&TopicArn=arn:aws:sns:us-east-1:123456789012:MyTopic&Token=2336412f37fb687f5d51e6e241d09c805a5a57b30d712f794cc5f6a988666d92768dd60a747ba6f3beb71854e285d6ad02428b09ceece29417f1f02d609c582afbacc99c583a916b9981dd2728f4ae6fdb82efd087cc3b7849e05798d2d2785c03b0879594eeac82c01f235d0e717736")
      end
    end

    describe "Receiving a bounce notification" do
      it "should file new bounces" do
        envelope = FactoryGirl.create(:valid_envelope)
        request.env['x-amz-sns-message-type'] = "Notification"
        request.env['User-Agent'] = "Amazon Simple Notification Service Agent"
        request.env['RAW_POST_DATA'] = {
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
              },
              {
                "emailAddress" => "othername@example.com"
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
        }.to_json

        expect {
          post :create
        }.to change(Msg::Bounce, :count).by(2)
      end
    end
  end
end
