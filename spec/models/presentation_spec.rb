require 'spec_helper'

describe Presentation do
  it 'informs if it is a short course based in its kind' do
    presentation = Presentation.new :kind => 'Minicurso'
    presentation.should be_a_short_course
  end

  it 'returns its title and speaker name as description' do
    presentation = Presentation.new(:title => 'Title',
                                    :speakers => [stub_model(Speaker, :name => 'Name'),
                                                  stub_model(Speaker, :name => 'Eman')])
    presentation.description.should == 'Title - Name, Eman'
  end

  it 'returns its confirmed registrations' do
    presentation = Presentation.new
    r1 = stub_model(Registration, :confirmed? => true)
    r2 = stub_model(Registration, :confirmed? => false)
    r3 = stub_model(Registration, :confirmed? => true)
    presentation.registrations = [r1, r2, r3]
    presentation.confirmed_registrations.should =~ [r1, r3]
  end

  it 'informs if it is crowded' do
    Factory.create(:crowded_short_course).should be_crowded
    Factory.create(:short_course).should_not be_crowded
  end

  describe 'class responsibilities' do
    it 'retrieves the short courses' do
      p1 = Factory.create :short_course
      p2 = Factory.create :short_course
      p3 = Factory.create :presentation

      Presentation.short_courses.should =~ [p1, p2]
    end

    it 'retrieves all available (not crowded) short courses' do
      p1 = Factory.create :crowded_short_course
      p2 = Factory.create :short_course
      p3 = Factory.create :presentation

      Presentation.available_short_courses.should == [p2]
    end
  end
end

