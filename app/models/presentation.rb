class Presentation < ActiveRecord::Base
  belongs_to :speaker
  has_many :registrations
  has_many :attendees, :through => :registrations

  def short_course?
    kind.try(:capitalize) == "Minicurso"
  end
end

