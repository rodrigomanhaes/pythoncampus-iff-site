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
end

