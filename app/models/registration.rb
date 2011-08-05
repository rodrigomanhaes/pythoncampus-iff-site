class Registration < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :presentation

  def description
    "#{attendee.name} - #{presentation.title}"
  end

  def confirmed?
    confirmed_at.present?
  end

  def confirm
    self.confirmed_at = Time.now
  end

  def confirm!
    confirm
    save!
  end

  def self.unconfirmed
    all.reject(&:confirmed?)
  end
end

