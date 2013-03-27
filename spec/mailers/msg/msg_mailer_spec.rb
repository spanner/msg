require "spec_helper"
include EmailSpec::Helpers
include EmailSpec::Matchers
module Msg
  describe MsgMailer do

    context "sending a message in an envelope" do
      before do
        @envelope = FactoryGirl.create(:valid_envelope)
        @email = Msg::MsgMailer.message_in_envelope(@envelope)
        @email.deliver
      end

      it "should have the right to: address" do
        @email.should deliver_to "#{@envelope.receiver.name} <#{@envelope.receiver.email}>"
      end

      it "should have the right from: address" do
        @email.should deliver_from @envelope.from_address
      end
      it "should have the right subject" do
        @email.should have_subject @envelope.subject
      end

      it "should have the right body" do
        @email.should have_body_text @envelope.send(:render_with_tracker)
      end

      it "should have the right message id" do
        ap @email["Message-ID"].inspect
        ap @envelope.email_id.class
        @email["Message-ID"].should == @envelope.email_id
      end

    end

  end
end
