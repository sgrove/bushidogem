require "spec_helper"

describe Bushido::Data do

  describe "add_observer" do
    it "should add an observer" do
      observers = ["sample_observer"]
      Bushido::Data.add_observer(observers.first)
      Bushido::Data.class_variable_get("@@observers").should == observers
    end
  end
  
end
