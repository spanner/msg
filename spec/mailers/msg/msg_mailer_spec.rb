require "spec_helper"

module Msg
  describe MsgMailer do

    context "sending a message in an envelope" do
      before do
        @envelope = FactoryGirl.create(:valid_envelope)
        @email = Msg::MsgMailer.message_in_envelope(@envelope)
        @email.deliver
      end

      it "should have the right to: address" do
        pending
      end
      it "should have the right from: address"
      it "should have the right subject"
      it "should have the right body"
      it "should have the right message id"

    end

  end
end