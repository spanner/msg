require 'spec_helper'

module Msg
  describe Msg::Bounce do

    # we get our bounce notifications from SNS so they have a very consistent structure

    before :each do
      @envelope = FactoryGirl.create(:envelope)
      @bounce = FactoryGirl.create(:bounce, :envelope => @envelope)
    end

    it "should require an envelope" do
      pp @envelope
    end

  end
end
