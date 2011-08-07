# coding: utf-8

require 'spec_helper'

feature 'confirm registration' do
  before :each do
    login

    create_short_course presentation: 'Hacking CPython', attendee: 'Guido da Silva'
    create_short_course presentation: 'Refactoring CPython', attendee: 'Guido da Silva'
    create_short_course presentation: 'Hacking Pip', attendee: 'Ian da Silva'
  end

  scenario 'happy path' do
    visit request_confirm_registrations_path
    check 'Guido da Silva - Hacking CPython'
    check 'Ian da Silva - Hacking Pip'
    click_button 'Confirmar'
    page.should have_content 'Inscrições confirmadas'
    within_fieldset("Hacking CPython") { page.should have_content 'Guido da Silva' }
    within_fieldset("Hacking Pip") { page.should have_content 'Ian da Silva' }
  end

  scenario 'last confirmed registrations are marked' do
    confirmed = 3.times.map { Factory.create(:confirmed_registration) }
    registration = Factory.create :registration
    visit request_confirm_registrations_path
    check registration.description
    click_button 'Confirmar'
    all('.confirmed_now').should have(1).result
    within('.confirmed_now') { page.should have_content registration.attendee.name }
  end

  scenario 'delete registration' do
    Registration.delete_all
    Factory.create :confirmed_registration
    Registration.count.should == 1
    visit registrations_path
    click_link 'Excluir'
    current_page.should == registrations_path
    within('#notice') { page.should have_content 'com sucesso' }
    Registration.count.should == 0
  end
end

