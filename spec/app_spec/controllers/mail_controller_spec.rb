require "spec_helper"

describe Bushido::MailController do
  
  describe "index" do
    before :each do
      # Rspec 1.3 doesn't support any_istance.
      # So we instead stub and object and return that instead 
      obj = Object.new

      Bushido::Mailroute.should_receive(:routes).and_return(obj)
      obj.should_receive(:process)
    end

    it "should return status 200" do
      post 'index'

      if defined?(Rails) && Rails::VERSION::MAJOR == 2
        response.status.should == "200 OK"
      else
        response.status.should == 200
      end
    end
  end

end

      
