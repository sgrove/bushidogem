require 'test_helper'

class DefaultRoutingTest < ActionController::TestCase
  test 'set passed variable' do
    assert_recognizes({:controller => 'bushido', :action => 'index'}, {:path => 'bushido', :method => :post})
  end
  
  test 'get passed variable' do
    assert_recognizes({:controller => 'bushido', :action => 'index'}, {:path => 'bushido', :method => :get})
  end

end