require 'spec_helper'

describe "Bushido::Platform" do
  describe "publish_url" do
    it "should return publish url" do
      Bushido::Platform.publish_url.should == "#{Bushido::Platform.host}/apps/#{Bushido::Platform.name}/bus"
    end
  end
end
