require 'spec_helper'

module Msg
  describe SendingsController do

    before :each do
      sign_in_admin
    end

    #new
    describe "GET #new" do
      it "should show the send-a-message form" do
        get :new, { :use_route => :msg }
        pending # response.body should contain form
      end
    end

    #create
    describe "POST #create" do
      it "should create a sending" do
        expect {
          post :create, { :sending => {}, :use_route => :msg }
        }.to change(Msg::Sending, :count).by(1)
      end
      it "should create many envelopes" do
        expect {
          post :create, { :sending => {}, :use_route => :msg }
        }.to change(Msg::Envelope, :count)
      end
    end

    #update
    describe "PUT #update" do
      it "should not update"
    end

    #show
    describe "GET #show" do
      it "should show a sending report"
    end

    #index
    describe "GET #index" do
      it "should render the outbox"
    end
  
  end
end
