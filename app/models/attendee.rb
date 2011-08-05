class Attendee < ActiveRecord::Base
  has_many :registrations
  has_many :presentations, :through => :registrations

  validates_presence_of :name, :email
  validates_format_of :email,
                      :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
                      :allow_blank => true
end

