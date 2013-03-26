require 'spec_helper'

module Msg
  describe Msg::Bounce do

    # we get our bounce notifications from SNS so they have a very consistent structure

    before :each do
      @bounce = FactoryGirl.create(:valid_bounce)
    end

    it "should require an envelope" do
      @bounce.should be_valid
      @bounce.envelope = nil
      @bounce.should_not be_valid
    end

  end
end
