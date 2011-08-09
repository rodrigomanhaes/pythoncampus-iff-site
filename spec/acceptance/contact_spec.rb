# coding: utf-8

require 'spec_helper'

feature 'contact' do
  scenario 'happy path' do
    visit contato_path
    fill_in 'Nome', :with => 'Rodrigo'
    fill_in 'E-mail', :with => 'rodrigo@nsi.iff.edu.br'
    fill_in 'Assunto', :with => 'Cool!'
    fill_in 'Mensagem', :with => 'Congratulations for this amazing PythOnCampus!'
    lambda {
      click_button 'Enviar'
    }.should change { ActionMailer::Base.deliveries.count }.by(1)

    page.should have_content 'Contato realizado com sucesso'
    ActionMailer::Base.deliveries.last.subject.should == 'Cool!'
  end
end

