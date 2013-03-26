require 'spec_helper'
include Devise::TestHelpers
module Msg
  describe EnvelopesController do

    before :each do
      @routes = Msg::Engine.routes
      sign_in_admin
    end

    it "should mark the requested envelope as open" do
      envelope = FactoryGirl.create(:valid_envelope)
      envelope.opened_at.should be_nil
      get :show, {:id => envelope.id }, valid_session
      assigns(:envelope).opened_at.should_not be_nil
    end

    it "should return a single pixel image file"
  end
end
