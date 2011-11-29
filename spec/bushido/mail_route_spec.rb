require 'spec_helper'

describe "Bushido::Mailroute" do
  def routes
    Bushido::Mailroute.routes
  end

  def constraints(route_name)
    Bushido::Mailroute.routes.routes[route_name][:constraints]
  end

  def params
    Bushido::Mailroute.routes.instance_variable_get("@params")
  end

  before(:each) do
    Bushido::Mailroute.clear_routes!

    @standard_email = mail = {'subject' => "Bushido: New modal sign-in", 'from' => "Sean Grove <s@gobushido.com>", 'body' => "this is the new modal sign-in form subscribe: s@busi.do"}
    @reply_email = @standard_email
    @reply_email['subject'] = "RE: Bushido: New modal sign-in"
  end

  context 'when drawing routes' do
    it 'should start with empty routes' do
      routes.routes.should == {}
    end

    it 'should create an internal instance of Bushido::Mailroute' do
      routes.routes.should == {}
      Bushido::Mailroute.map { }
      routes.class.should == Bushido::Mailroute
    end

    it 'should have field matchers for standard email fields' do
      [:from, :sender, :subject, :body].each do |field|
        routes.methods.should include(field)
      end
    end

    it 'should create a route for each callback added' do
      Bushido::Mailroute.map do |mapper|
        mapper.match('test-call-back') { }
      end

      routes.routes.should == {"test-call-back"=>{:rules => [], :constraints => []}}
    end

    it 'should create a route with rules for each callback added' do
      Bushido::Mailroute.map do |mapper|
        mapper.match('test-call-back') { mapper.from('test-sender') }
      end

      routes.routes.should == {"test-call-back"=>{:rules => [["from", "/test-sender/", nil]], :constraints => []}}
    end

    it 'should allow composable rules for the same field' do
      Bushido::Mailroute.map do |mapper|
        mapper.match('test-call-back') {
          mapper.body('event on :day',  {:constraints => {:day   => mapper.word             }})
          mapper.body('at :time',       {:constraints => {:time  => mapper.ampm             }})
          mapper.body('meet at :place', {:constraints => {:place => mapper.words_and_spaces }})
        }
      end

      mail = @standard_email.dup
      mail['body'] = "Hey everyone, there's an event on Wednesday at 7PM. We'll meet at The PubHouse, then we'll head over!"

      routes.process(mail)
      puts params
      params['day'].should == 'Wednesday'
      params['time'].should == '7PM'
      params['place'].should == 'The PubHouse'
      
    end

    it 'should allow for composable rules in any order' do
      Bushido::Mailroute.map do |mapper|
        mapper.match('test-call-back') {
          mapper.body('event on :day',  {:constraints => {:day   => mapper.word              }})
          mapper.body('at :time',       {:constraints => {:time  => mapper.ampm              }})
          mapper.body('meet at :place', {:constraints => {:place => mapper.words_and_spaces  }})
        }
      end

      mail = @standard_email.dup
      mail['body'] = "Hey everyone, we'll meet at The PubHouse, at 7PM for the event on Wednesday. Then we'll head over!"

      routes.process(mail)
      puts params
      params['day'].should == 'Wednesday'
      params['time'].should == '7PM'
      params['place'].should == 'The PubHouse'
      
    end
  end

  context 'when adding constraints' do
    it 'should raise an error if an unknown check is specified' do
      lambda {
        Bushido::Mailroute.map do |mapper|
          mapper.match('test-callback') do 
            mapper.add_constraint(:reply, :invalid_checker)
          end
        end
      }.should raise_error(StandardError)
    end
    

    it 'should add the constraint for the param field' do
      Bushido::Mailroute.map do |mapper|
        mapper.match('test-callback') do
          mapper.add_constraint(:reply, :required)
        end
      end

      constraints('test-callback').size.should == 1
      constraints('test-callback').first.class.should == Proc
    end
  end

  context 'when processing routes' do
    before(:each) do
      Bushido::Mailroute.clear_routes!

      @standard_email = {'subject' => "Bushido: New modal sign-in", 'from' => "Sean Grove <s@gobushido.com>", 'body' => "this is the new modal sign-in form subscribe: s@busi.do"}
      @reply_email = @standard_email.dup
      @reply_email['subject'] = "RE: Bushido: New modal sign-in"


      Bushido::Mailroute.map do |mapper|
        mapper.match('example-callback') do
          mapper.add_constraint(:reply, :required)

          mapper.subject("^:prefix: :command",
                         :constraints => {
                           :prefix => /[a-zA-Z \-_!]*/,
                           :command => /[a-zA-Z \-_!]*/})
        end
      end
    end

    it "should set 'reply' => nil to the params if not a reply" do
      routes.process(@standard_email)

      params['reply'].should == nil
    end
    
    it "should strip the RE: from a mail subject and set 'reply' => true to the params" do
      routes.process(@reply_email)
      params['reply'].should == true
      params['mail']['subject'].should == @standard_email['subject']
    end

    it "should fire the callback when finding a successful route" do
      Bushido::Data.should_receive(:fire).with(instance_of(Hash), 'example-callback')

      routes.process(@reply_email)
    end

    it "should set 'from_email' and 'from_name' in params if available" do
      @standard_email['from'] = 'Test Sender <test@gobushido.com>'
      routes.process(@standard_email)
      params['from_email'].should == 'test@gobushido.com'
      params['from_name'].should == 'Test Sender'
    end
  end
end

