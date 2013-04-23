require "spec_helper"

describe "Bounce notification" do

  it "creates some Bounce objects" do
    envelope = FactoryGirl.create(:valid_envelope)
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
    }
    
    post msg.bounces_url, bounce.to_json, {'x-amz-sns-message-type' => "Notification", 'Content-Type' => 'text/plain; charset=UTF-8'}
    expect(response).to be_success
  end

end
