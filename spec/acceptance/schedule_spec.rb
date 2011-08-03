# coding: utf-8

require 'spec_helper'

feature 'schedule' do
  scenario 'show presentations' do
    speaker = Speaker.create!(
      :name => 'Rodrigo Manhães',
      :summary => 'Desenvolvedor de software, vocalista de grindcore e baterista de pop rock',
      :organization => 'NSI',
      :twitter => 'rodrigomanhaes',
      :github => 'rodrigomanhaes',
      :site => 'http://programacaoradical.blogspot.com')
    presentation = Presentation.create!(
      :kind => 'Minicurso',
      :title => 'Coisas que até Guido duvida',
      :time => '08:00',
      :room => 'Laboratório 10',
      :speaker => speaker,
      :summary => 'Extraia o máximo da linguagem Python usando truques sujos')

    visit programacao_path

    within '.cabecalho' do
      page.should have_content 'Minicurso - Coisas que até Guido duvida'
      page.should have_content '08:00'
    end
    page.should have_content 'Extraia o máximo da linguagem Python usando truques sujos'
    within '.responsavel' do
      page.should have_content 'Rodrigo Manhães'
      page.should have_content 'Desenvolvedor de software'
      page.should have_content 'Organização: NSI'
      page.should have_link_to 'https://github.com/rodrigomanhaes'
      page.should have_link_to 'http://twitter.com/rodrigomanhaes'
      page.should have_link_to 'http://programacaoradical.blogspot.com'
    end
  end
end

