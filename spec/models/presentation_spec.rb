require 'spec_helper'

describe Presentation do
  it 'informs if it is a short course based in its kind' do
    presentation = Presentation.new :kind => 'Minicurso'
    presentation.should be_a_short_course
  end
end

