require 'spec_helper'

describe Bushido::EnvsController do
  before(:each) do
    ENV["BUSHIDO_APP_KEY"] = "abc123"
  end
  
  context "updating env vars" do
    describe "PUT '/bushido/envs'" do
      it "should return 405 when given the wrong key" do
        preserve_envs("BUSHIDO_EXAMPLE", "BUSHIDO_APP_KEY", "BUSHIDO_ENV") do
          post :update, {:key => "not-the-key", :id => "BUSHIDO_EXAMPLE", :value => "value"}
          ENV["BUSHIDO_EXAMPLE"].should be_nil
        end
      end

      it "should update the ENV var when given the right key" do
        preserve_envs("BUSHIDO_EXAMPLE", "BUSHIDO_APP_KEY", "BUSHIDO_ENV") do
          post :update, {:key => ENV["BUSHIDO_APP_KEY"].dup, :id => "BUSHIDO_EXAMPLE", :value => "value"}
          ENV["BUSHIDO_EXAMPLE"].should == "value"
        end
      end
    end
  end
end
