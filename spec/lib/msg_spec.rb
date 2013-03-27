require 'spec_helper'

describe Msg do

  it "should provide defaults" do
    Msg.default_from_address = nil
    Msg.default_from_address.should_not be_nil
  end

  it "should accept overrides" do
    Msg.default_from_address = "my@email.org"
    Msg.default_from_address.should eq "my@email.org"
  end

end
