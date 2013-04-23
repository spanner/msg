require 'spec_helper'
module Msg
  describe SendingsController do
    describe "routing" do
      it "routes to #index" do
        get("/msg/sendings").should route_to("msg/sendings#index")
      end

      it "routes to #show" do
        get("/msg/sendings/1").should route_to("msg/sendings#show", :id => "1")
      end

      it "routes to #new" do
        get("/msg/sendings/new").should route_to("msg/sendings#new")
      end

      it "routes to #create" do
        post("/msg/sendings").should route_to("msg/sendings#create")
      end

      it "routes to #destroy" do
        delete("/msg/sendings/1").should route_to("msg/sendings#destroy", :id => "1")
      end
    end
  end
end
