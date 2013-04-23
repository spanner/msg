require 'spec_helper'

module Msg
  describe Message do

    # Receivers must define a for_email method, which returns the hash we pass to the mustache
    # template. In the dummy we can use any old value just to test that they get through.
    it "should interpolate values provided by the receiver"
    it "should accept tags allowed in Msg configuration"
    it "should reject tags not allowed in Msg configuration"
    it "should accept attributes allowed in Msg configuration"
    it "should reject attributes not allowed in Msg configuration"

  end
end
