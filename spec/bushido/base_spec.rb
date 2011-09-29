require 'spec_helper'

describe "Bushido::Base" do

  def url_helpers
    {
      :unity=>[:valid,  :exists,
               :invite, :pending_invites,
               :remove],

      :email=>[:send]
    }
  end

  it "should have url helper methods" do
    
    url_helpers.stringify_keys.each do |prefix, method_names|
      method_names.each do |m|
        full_method_name = m.to_s + "_" + prefix + "_" + "url"
        Bushido::Base.send(full_method_name.to_sym).should be_kind_of(String)
      end
    end
  end

end
