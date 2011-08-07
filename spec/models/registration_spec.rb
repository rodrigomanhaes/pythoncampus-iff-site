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

  context 'class responsibilities' do
    describe 'retrieves registrations available for confirmation' do
      before :each do
        @crowded_presentation = Factory.create :crowded_short_course
        @presentation = Factory.create :short_course
      end

      it 'unconfirmed' do
        r1 = Factory.create :registration, :presentation => @presentation
        r2 = Factory.create :registration, :presentation => @presentation, :confirmed_at => Time.now
        r3 = Factory.create :registration, :presentation => @presentation
        Registration.available_for_confirmation.should =~ [r1, r3]
      end

      it 'not associated to crowded presentations' do
        r1 = Factory.create :registration, :presentation => @crowded_presentation
        r2 = Factory.create :registration, :presentation => @presentation
        r3 = Factory.create :registration, :presentation => @presentation, :confirmed_at => Time.now
        Registration.available_for_confirmation.should == [r2]
      end
    end
  end
end

