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
    check @pip.title
    check @pypy.title
    click_button 'Inscrever'

    page.should have_content 'Pythonista da Silva'
    page.should have_content "você acaba de realizar sua pré-inscrição " +
                             "nos minicursos #{@pip.title} e #{@pypy.title}"
    page.should have_content "Seu código de inscrição é #{Attendee.first.id}"
  end
end

