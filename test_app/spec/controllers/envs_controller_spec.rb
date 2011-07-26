require 'spec_helper'

describe Bushido::EnvsController do
  before(:each) do
    ENV["BUSHIDO_APP_KEY"] = "abc123"
  end
  
  context "updating env vars" do
    describe "PUT '/bushido/envs'" do
      it "should check that the key in param matches the key in env" do
        post :update, {:key => ENV["BUSHIDO_APP_KEY"], :id => "BUSHIDO_EXAMPLE", :value => "value"}
        ENV["BUSHIDO_EXAMPLE"].should == "value"
      end
    end
  end
end
