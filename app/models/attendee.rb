class Attendee < ActiveRecord::Base
  has_many :registrations
  has_many :presentations, :through => :registrations

  validates_presence_of :name, :email
end

