require 'spec_helper'
module Msg
  describe SendingsController do
    describe "routing" do
      it "routes to #index" do
        pending
        get("/sendings").should route_to("msg/sendings#index")
      end

      it "routes to #show" do
        pending
        get("/sendings/1").should route_to("msg/sendings#show", :id => "1")
      end

      it "routes to #new" do
        pending
        get("/sendings/new").should route_to("msg/sendings#new")
      end

      it "routes to #create" do
        pending
        post("/sendings").should route_to("msg/sendings#create")
      end

      it "routes to #destroy" do
        pending
        delete("/sendings/1").should route_to("msg/sendings#destroy", :id => "1")
      end
    end
  end
end
