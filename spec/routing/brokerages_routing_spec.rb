require "spec_helper"

describe BrokeragesController do
  describe "routing" do

    it "routes to #index" do
      get("/brokerages").should route_to("brokerages#index")
    end

    it "routes to #new" do
      get("/brokerages/new").should route_to("brokerages#new")
    end

    it "routes to #show" do
      get("/brokerages/1").should route_to("brokerages#show", :id => "1")
    end

    it "routes to #edit" do
      get("/brokerages/1/edit").should route_to("brokerages#edit", :id => "1")
    end

    it "routes to #create" do
      post("/brokerages").should route_to("brokerages#create")
    end

    it "routes to #update" do
      put("/brokerages/1").should route_to("brokerages#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/brokerages/1").should route_to("brokerages#destroy", :id => "1")
    end

  end
end
