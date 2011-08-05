class Attendee < ActiveRecord::Base
  has_many :registrations
  has_many :presentations, :through => :registrations
end

