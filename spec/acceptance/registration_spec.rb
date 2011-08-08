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
    select @pip.description, :on => 'Minicurso'
    click_button 'Inscrever'

    page.should have_content 'Pythonista da Silva (silva@pythoncampus.org)'
    page.should have_content "você acaba de realizar sua pré-inscrição " +
                             "no minicurso #{@pip.title}"
    page.should have_content "Seu código de inscrição é #{Attendee.first.id}"
  end

  scenario 'registration shows only short courses, not talks' do
    visit inscricao_path
    id = field_labeled("Minicurso")[:id]
    [@pypy, @meta, @pip].map(&:description).each do |description|
      page.should have_xpath "//select[@id='%s']/option[text()='%s']" % [
        id, description]
    end
    page.should_not have_xpath "//select[@id='%s']/option[text()='%s']" % [
      id, @wsgi.title]
  end

  scenario 'crowded short courses are not shown' do
    20.times { Factory.create :confirmed_registration, :presentation => @pypy }
    visit inscricao_path
    id = field_labeled("Minicurso")[:id]
    page.should_not have_xpath "//select[@id='%s']/option[text()='%s']" % [id, @pypy.description]
    page.should have_xpath "//select[@id='%s']/option[text()='%s']" % [id, @meta.description]
    page.should have_xpath "//select[@id='%s']/option[text()='%s']" % [id, @pip.description]
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

