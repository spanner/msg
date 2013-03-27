require 'spec_helper'

module Msg
  describe SendingsController do

    before :each do
      @routes = Msg::Engine.routes
      sign_in_admin
      @message = FactoryGirl.create(:message)
    end

    #new
    describe "GET #new" do
      it "should show the send-a-message form" do
        get :new, { :message_id => @message.id }
        pending # response.body should contain form
      end
    end

    #create
    describe "POST #create" do
      it "should create a sending" do
        expect {
          post :create, { :message_id => @message.id, :sending => {} }
        }.to change(Msg::Sending, :count).by(1)
      end
      it "should create many envelopes" do
        expect {
          post :create, { :message_id => @message.id, :sending => {} }
        }.to change(Msg::Envelope, :count)
      end
    end

    #update
    describe "PUT #update" do
      it "should not update" do
        sending = FactoryGirl.create(:sending, :message => @message)
        post :update, { :message_id => @message.id, :sending_id => sending.id }
      end
    end

    #show
    describe "GET #show" do
      it "should show a sending report"
    end

    #index
    describe "GET #index" do
      it "should render the outbox" do
        get :index, { }
      end
    end
  
  end
end
