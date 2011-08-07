class Presentation < ActiveRecord::Base
  belongs_to :speaker
  has_many :registrations
  has_many :attendees, :through => :registrations

  MAXIMUM_CAPACITY = 20

  def short_course?
    kind.try(:capitalize) == "Minicurso"
  end

  def self.short_courses
    all.select(&:short_course?)
  end

  def description
    "#{title} - #{speaker.name}"
  end

  def confirmed_registrations
    registrations.select(&:confirmed?)
  end

  def self.available_short_courses
    short_courses.reject(&:crowded?)
  end

  def crowded?
    confirmed_registrations.count >= MAXIMUM_CAPACITY
  end
end

