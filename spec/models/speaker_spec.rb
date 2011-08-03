require 'spec_helper'

describe Speaker do
  it 'generates twitter link' do
    speaker = Speaker.new
    valid_users = %w(@rodrigomanhaes rodrigomanhaes)
    blank_users = [nil, "", "    "]

    valid_users.each do |user|
      speaker.twitter = user
      speaker.twitter_link.should == 'http://twitter.com/rodrigomanhaes'
    end

    blank_users.each do |user|
      speaker.twitter = user
      speaker.twitter_link.should be_nil
    end
  end

  it 'generates github link' do
    speaker = Speaker.new(:github => 'BecaMotta')
    speaker.github_link.should == 'https://github.com/BecaMotta'
    blank_users = [nil, "", "    "]
    blank_users.each do |user|
      speaker.github = user
      speaker.github_link.should be_nil
    end
  end
end

