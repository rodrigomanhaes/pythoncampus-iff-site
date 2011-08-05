# coding: utf-8

require 'spec_helper'

feature 'registration' do
  before :each do
    @pypy = Factory.create :short_course, :title => 'Pypy Performance'
    @meta = Factory.create :short_course, :title => 'Metaprogramming Python'
    @wsgi = Factory.create :presentation, :title => 'Profiling in WSGI applications'
    @pip = Factory.create :short_course, :title => 'Hacking Pip'
  end

  scenario 'happy path' do
    visit inscricao_path

    fill_in 'Nome', :with => 'Pythonista da Silva'
    fill_in 'E-mail', :with => 'silva@pythoncampus.org'
    check @pip.description
    check @pypy.description
    click_button 'Inscrever'

    page.should have_content 'Pythonista da Silva (silva@pythoncampus.org)'
    page.should have_content "você acaba de realizar sua pré-inscrição " +
                             "no(s) minicurso(s) #{@pip.title} e #{@pypy.title}"
    page.should have_content "Seu código de inscrição é #{Attendee.first.id}"
  end

  scenario 'registration shows only short courses, not talks' do
    visit inscricao_path

    page.should have_content @pypy.description
    page.should have_content @meta.description
    page.should have_content @pip.description
    page.should_not have_content @wsgi.title
  end

  context 'validations' do
    before(:each) { visit inscricao_path }

    scenario 'e-mail is required' do
      click_button 'Inscrever'
      within('#attendee_email_input') { page.should have_content 'não pode ficar em branco' }
    end

    scenario 'name is required' do
      click_button 'Inscrever'
      within('#attendee_name_input') { page.should have_content 'não pode ficar em branco' }
    end

    scenario 'email should be valid' do
      fill_in 'E-mail', :with => 'rmanhaes@email.1'
      click_button 'Inscrever'
      within('#attendee_email_input') { page.should have_content 'não é válido' }
    end
  end
end

