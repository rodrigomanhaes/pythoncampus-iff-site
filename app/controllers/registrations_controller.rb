class RegistrationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:request_confirm, :confirm]

  def request_confirm
    @registrations = Registration.unconfirmed.sort_by(&:description)
  end

  def confirm
    @new_registrations = params[:registrations].map {|id| Registration.find(id) }
    @new_registrations.each {|registration| registration.confirm! }
  end
end

