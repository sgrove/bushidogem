require "spec_helper"

describe Bushido::EnvsController do
  before :each do
    ENV["BUSHIDO_APP_KEY"] = "sample-key"
  end

  describe "env var update request" do
    it "should return 405 when given the wrong key" do
      preserve_envs("BUSHIDO_EXAMPLE", "BUSHIDO_APP_KEY", "BUSHIDO_ENV") do
        post :update, {:key => "wrong-key", :id=>"BUSHIDO_EXAMPLE"}
        ENV["BUSHIDO_EXAMPLE"].should be_nil
      end
    end

    it "should update the env var when the BUSHIDO_APP_KEY is correct" do
      preserve_envs("BUSHIDO_EXAMPLE", "BUSHIDO_APP_KEY", "BUSHIDO_ENV") do
        post :update, {:key => ENV["BUSHIDO_APP_KEY"], :id => "BUSHIDO_EXAMPLE"}
        ENV["BUSHIDO_EXAMPLE"].should == "value"
      end
    end
  end
  
end

