require 'spec_helper'
include Devise::TestHelpers
module Msg
  describe EnvelopesController do
    def valid_attributes
    end

    def valid_session
    end

    it "should mark the requested envelope as open" do
      envelope = FactoryGirl.create(:valid_envelope)
      sign_in FactoryGirl.create(:admin)
      envelope.opened_at.should be_nil
      get :show, {:id => envelope.id, :use_route => :msg}, valid_session
      assigns(:envelope).opened_at.should_not be_nil
    end

    it "should return a single pixel image file"
  end
end
