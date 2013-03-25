require "spec_helper"

module Msg
  describe MsgMailer do

    context "sending a message in an envelope" do
      before do
        @envelope = FactoryGirl.create(:msg_envelope)
        @email = Msg::MsgMailer.message_in_envelope(envelope).deliver
      end

      it "should have the right to: address"
      it "should have the right from: address"
      it "should have the right subject"
      it "should have the right body"
      it "should have the right message id"

    end

  end
end
