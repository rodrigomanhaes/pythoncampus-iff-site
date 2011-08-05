require 'spec_helper'

describe Presentation do
  it 'informs if it is a short course based in its kind' do
    presentation = Presentation.new :kind => 'Minicurso'
    presentation.should be_a_short_course
  end

  it 'returns its title and speaker name as description' do
    presentation = Presentation.new(:title => 'Title',
                                    :speaker => stub_model(Speaker, :name => 'Name'))
    presentation.description.should == 'Title - Name'
  end

  it 'returns its confirmed registrations' do
    presentation = Presentation.new
    r1 = stub_model(Registration, :confirmed? => true)
    r2 = stub_model(Registration, :confirmed? => false)
    r3 = stub_model(Registration, :confirmed? => true)
    presentation.registrations = [r1, r2, r3]
    presentation.confirmed_registrations.should =~ [r1, r3]
  end

  describe 'class' do
    it 'retrieves the short courses' do
      p1 = Factory.create :short_course
      p2 = Factory.create :short_course
      p3 = Factory.create :presentation

      Presentation.short_courses.should =~ [p1, p2]
    end
  end
end

