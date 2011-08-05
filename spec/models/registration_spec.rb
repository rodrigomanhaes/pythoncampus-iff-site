require 'spec_helper'

describe Registration do
  it 'returns attendee name and presentation title as its description' do
    registration = Registration.new(
      :presentation => stub_model(Presentation, :title => 'A Cool Presentation'),
      :attendee => stub_model(Attendee, :name => 'Noob da Silva'))
    registration.description.should == 'Noob da Silva - A Cool Presentation'
  end

  it 'is confirmed if has a confirm date' do
    Registration.new.should_not be_confirmed
    Registration.new(:confirmed_at => nil).should_not be_confirmed
    Registration.new(:confirmed_at => Date.today).should be_confirmed
  end

  it 'confirms itself at current time' do
    registration = Factory.create :registration
    registration.should_not be_confirmed
    now = Time.now
    Timecop.freeze(now) { registration.confirm! }
    registration.should be_confirmed
    registration.confirmed_at.should == now
  end

  describe 'class responsibilities' do
    it 'retrieves all unconfirmed registrations' do
      r1 = Registration.create!
      r2 = Registration.create!(:confirmed_at => Time.now)
      r3 = Registration.create!

      Registration.unconfirmed.should == [r1, r3]
    end
  end
end

