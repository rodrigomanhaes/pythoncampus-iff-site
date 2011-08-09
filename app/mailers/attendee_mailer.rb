# coding: utf-8

class AttendeeMailer < ActionMailer::Base
  default :from => 'pythoncampus2011@gmail.com'

  def pre_registration_email(attendee)
    @attendee = attendee
    mail(:to => attendee.email, :subject => 'Confirme sua presença!')
  end
end

