require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def under_construction
  end

  def map
  end

  def team
    scrapper = NsiMemberScrapper.new(open("#{NsiMemberScrapper::NSI_SITE}/membros"))
    @content, @members_css_link = scrapper.content, scrapper.members_css_link
  end

  def contact
    @contact = Contact.new
  end

  def send_contact
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      AttendeeMailer.contact_email(@contact).deliver
      redirect_to root_path
      flash[:notice] = 'Contato realizado com sucesso'
    else
      render :action => :contact
    end
  end
end

class Contact < ActiveModelForm
  attr_accessor :name, :email, :subject, :message
  validates_presence_of :name, :email, :subject, :message
end

