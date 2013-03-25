require "spec_helper"

module Msg
  describe MsgDeviseMailer do

    context "sending a transactional message" do
      before do
        @user = 
        @email = Msg::MsgDeviseMailer.message_in_envelope(envelope).deliver
      end

      it "should have the right to: address"
      it "should have the right from: address"
      it "should have the right subject"
      it "should have the right body"
      it "should have the right message id"

    end

  end
end
