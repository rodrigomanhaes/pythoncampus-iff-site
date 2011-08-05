class Registration < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :presentation
end
