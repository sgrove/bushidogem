require 'spec_helper'

describe 'claiming an app' do
  it "marks claimed = false in the markup" do
    visit "/"
    puts "#{page.body}"
    page.body.include?("var _bushido_claimed = false;").should be_true
  end

  it "marks claimed = false in the markup" do
    preserve_envs("BUSHIDO_CLAIMED") do
      ENV["BUSHIDO_CLAIMED"] = "true"
      visit "/"
      puts "#{page.body}"
      page.body.include?("var _bushido_claimed = true;").should be_true
    end
  end
end
