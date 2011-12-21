require 'spec_helper'

describe "Bushido::Config" do
  
  it "should have API version" do
    Bushido::Config.api_version.should be_a_kind_of(String)
  end

end
