# coding: utf-8

class RegistrationsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def request_confirm
    @registrations = Registration.available_for_confirmation.sort_by(&:description)
  end

  def confirm
    @new_registrations = params[:registrations].map {|id| Registration.find(id) }
    @new_registrations.each {|registration| registration.confirm! }
    render :action => :index
  end

  def destroy
    Registration.find(params[:id]).delete
    flash[:notice] = 'Inscrição excluída com sucesso'
    redirect_to :action => :index
  end
end

