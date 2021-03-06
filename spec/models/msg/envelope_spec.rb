require 'spec_helper'

module Msg
  describe Envelope do

    before :each do
      @envelope = FactoryGirl.create(:valid_envelope)
      @message = @envelope.message
    end

    it "should require a receiver" do
      @envelope.should be_valid
      @envelope.receiver = nil
      @envelope.should_not be_valid
    end

    it "should require a sending" do
      @envelope.should be_valid
      @envelope.sending = nil
      @envelope.should_not be_valid
    end

    it "should by default be marked unopened" do
      @envelope.opened_at.should be_nil
    end

    it "should be marked opened once opened" do
      @envelope.open!
      @envelope.opened_at.should_not be_nil
    end

    it "should store the message subject" do
      @envelope.subject.should_not be_nil
      @envelope.subject.should eq @message.subject
    end

    it "should store the message to: address" do
      @envelope.to_address.should_not be_nil
      @envelope.to_address.should eq @envelope.receiver.email
    end

    it "should store the message from: address" do
      @envelope.from_address.should_not be_nil
      @envelope.from_address.should eq "#{@message.from_name} <#{@message.from_address}>"
    end

    it "should send the message" do
      @envelope.send(:send_email)
      @envelope.sent_at.should_not be_nil
      mail = ActionMailer::Base.deliveries.last
      mail[:from].to_s.should == @envelope.from_address
      mail[:subject].to_s.should == @envelope.subject
      mail[:message_id].to_s.should == @envelope.email_id.to_s
    end

  end
end
