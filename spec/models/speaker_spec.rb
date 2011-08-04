require 'spec_helper'
require 'digest'

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

  describe 'generates photo link' do
    context 'photo exists' do
      it 'gets from paperclip' do
        speaker = Speaker.new
        speaker.stub(:photo).and_return(stub(:exists? => true, :url => 'photo.png'))
        speaker.photo_link.should == 'photo.png'
      end
    end

    context "photo doesn't exist" do
      it 'retrieves from gravatar' do
        speaker = Speaker.new(:email => 'speaker@pythoncampus.org', :photo => nil)
        Digest::MD5.stub(:hexdigest).with('speaker@pythoncampus.org').and_return('12345')
        speaker.photo_link.should == 'http://gravatar.com/avatar.php?gravatar_id=12345'

        speaker.email = nil
        speaker.photo_link.should be_nil
      end
    end
  end
end

