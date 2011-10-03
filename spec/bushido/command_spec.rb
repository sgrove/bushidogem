require 'spec_helper'

describe "Bushido::Command" do
  
  before :each do
    @dummy_url = "/sample_api_path"
    @api_params = @sample_result = @rest_params = {:key1=>"value1", :key2=>"value2"}
    @rest_params.merge!({:auth_token => Bushido::Platform.key}) if params[:auth_token].nil? unless Bushido::Platform.key.nil?
  end

  describe "last_command_successful?" do
    it "should initially return true" do
      Bushido::Command.last_command_successful?.should be_true
    end

    it "should return false if the last command errored" do
      # TODO test it by stubbing out a request to error
    end
  end

  describe "last_command_errored?" do
    it "should initially return false" do
      Bushido::Command.last_command_errored?.should be_false
    end

    it "should return true if the last command errored" do
      # TODO test it by stubbing out a request to error
    end
  end

  describe "request_count" do
    it "should initially be 0" do
      Bushido::Command.request_count == 0
    end

    it "should return the request count" do
      Bushido::Command.class_eval "@@request_count = 42"
      Bushido::Command.request_count.should == 42
    end
  end

  describe "show_response" do
    before :each do
      @response = {:messages => ["value1", "value2"],
                   :errors => ["value1", "value2"]}
    end
    it "should show messages" do
      Bushido::Command.should_receive(:show_messages).with(@response)
      Bushido::Command.show_response(@response)
    end

    it "should show errors" do
      Bushido::Command.should_receive(:show_errors).with(@response)
      Bushido::Command.show_errors(@response)
    end
  end

  # GET request
  describe "get_command" do
    describe "valids" do
      before :each do
        RestClient.should_receive(:get).
          with(@dummy_url, {:params => @rest_params, :accept => :json}).
          and_return(@sample_result.to_json)
      end

      it "should increment the request count" do
        expect {
          Bushido::Command.get_command(@dummy_url, @api_params)
        }.to change(Bushido::Command, :request_count).by(1)
      end

      it "should set last command as successful" do
        Bushido::Command.get_command(@dummy_url, @api_params)
        Bushido::Command.last_command_successful?.should be_true
      end

      it "should return the request result" do
        # JSON parsing returns stringified keys
        Bushido::Command.get_command(@dummy_url, @api_params).should == @sample_result.stringify_keys
      end
    end

    describe "invalids" do
      before :each do
        RestClient.should_receive(:get).
          with(@dummy_url, {:params => @rest_params, :accept => :json}).
          and_throw(:any_exception)
      end

      it "should set last command as failed" do
        Bushido::Command.get_command(@dummy_url, @api_params)
        Bushido::Command.last_command_errored?.should be_true
      end

      it "should return nil" do
        Bushido::Command.get_command(@dummy_url, @api_params).should == nil
      end
    end
  end

  # POST request
  describe "post_command" do
    describe "valids" do
      before :each do
        RestClient.should_receive(:post).
          with(@dummy_url, @rest_params.to_json, :content_type => :json, :accept => :json).
          and_return(@sample_result.to_json)
      end
     
      it "should increment the request count" do
        expect {
          Bushido::Command.post_command(@dummy_url, @api_params)
        }.to change(Bushido::Command, :request_count).by(1)
      end

      it "should set last command as successful" do
        Bushido::Command.post_command(@dummy_url, @api_params)
        Bushido::Command.last_command_successful?.should be_true
      end

      it "should return the request result" do
        Bushido::Command.post_command(@dummy_url, @api_params).should == @sample_result.stringify_keys
      end
    end

    describe "invalids" do
      before :each do
        RestClient.should_receive(:post).
          with(@dummy_url, @rest_params.to_json, :content_type => :json, :accept => :json).
          and_throw(:exception)
      end

      it "should set last command as failed" do
        Bushido::Command.post_command(@dummy_url, @api_params)
        Bushido::Command.last_command_errored?.should be_true
      end

      it "should return nil" do
        Bushido::Command.post_command(@dummy_url, @api_params).should == nil
      end
    end
  end

  # PUT request
  describe "put_command" do
    describe "valids" do
      before :each do
        RestClient.should_receive(:put).
          with(@dummy_url, @rest_params.to_json, :content_type => :json).
          and_return(@sample_result.to_json)
      end
     
      it "should increment the request count" do
        expect {
          Bushido::Command.put_command(@dummy_url, @api_params)
        }.to change(Bushido::Command, :request_count).by(1)
      end

      it "should set last command as successful" do
        Bushido::Command.put_command(@dummy_url, @api_params)
        Bushido::Command.last_command_successful?.should be_true
      end

      it "should return the request result" do
        Bushido::Command.put_command(@dummy_url, @api_params).should == @sample_result.stringify_keys
      end
    end

    describe "invalids" do
      before :each do
        RestClient.should_receive(:put).
          with(@dummy_url, @rest_params.to_json, :content_type => :json).
          and_throw(:exception)
      end

      it "should set last command as failed" do
        Bushido::Command.put_command(@dummy_url, @api_params)
        Bushido::Command.last_command_errored?.should be_true
      end

      it "should return nil" do
        Bushido::Command.put_command(@dummy_url, @api_params).should == nil
      end
    end

  end

end
