require 'spec_helper'

describe Presentation do
  it 'informs if it is a short course based in its kind' do
    presentation = Presentation.new :kind => 'Minicurso'
    presentation.should be_a_short_course
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

