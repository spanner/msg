require 'spec_helper'

module Msg
  describe Envelope do

    before :each do
      @envelope = FactoryGirl.create(:envelope)
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

    it "should generate a tracker url" do
      pending
    end

    it "should by default be marked unopened" do
      
    end
    it "should be marked opened once opened"
    it "should store the message subject"
    it "should store the message to: address"
    it "should store the message from: address"
    it "should render the message contents"
    it "should append a tracker dot to the message"
    it "should send the message"
    
  end
end
