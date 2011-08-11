# coding: utf-8

require 'spec_helper'

feature 'schedule' do
  scenario 'show presentations' do
    speaker1 = Speaker.create!(
      :name => 'Rodrigo Manhães',
      :summary => 'Desenvolvedor de software, vocalista de grindcore e baterista de pop rock',
      :organization => 'NSI',
      :twitter => 'rodrigomanhaes',
      :github => 'rodrigomanhaes',
      :site => 'http://programacaoradical.blogspot.com',
      :photo => File.open(File.join(RESOURCES_FOLDER, 'trollface.png')))
    speaker2 = Speaker.create!(
      :name => 'Guido van Rossum',
      :summary => 'Criador do Python',
      :organization => 'Google',
      :twitter => 'gvanrossum',
      :site => 'http://neopythonic.blogspot.com',
      :photo => File.open(File.join(RESOURCES_FOLDER, 'trollface.png')))
    presentation = Presentation.create!(
      :kind => 'Minicurso',
      :title => 'Coisas que até Guido duvida',
      :time => '08:00',
      :room => 'Laboratório 10',
      :speakers => [speaker1, speaker2],
      :summary => 'Extraia o máximo da linguagem Python usando truques sujos')

    visit programacao_path

    within '.cabecalho' do
      page.should have_content 'Minicurso - Coisas que até Guido duvida'
      page.should have_content '08:00'
    end
    page.should have_content 'Extraia o máximo da linguagem Python usando truques sujos'
    page.should have_content 'Local: Laboratório 10'
    within '.responsavel' do
      page.should have_content 'Rodrigo Manhães'
      page.should have_content 'Desenvolvedor de software'
      page.should have_content 'Organização: NSI'
      page.should have_link_to 'https://github.com/rodrigomanhaes'
      page.should have_link_to 'http://twitter.com/rodrigomanhaes'
      page.should have_link_to 'http://programacaoradical.blogspot.com'
      page.should have_image 'trollface.png'
    end
    within '.responsavel:last-of-type' do
      page.should have_content 'Guido van Rossum'
      page.should have_content 'Criador do Python'
      page.should have_content 'Organização: Google'
      page.should have_link_to 'http://twitter.com/gvanrossum'
      page.should have_link_to 'http://neopythonic.blogspot.com'
      page.should have_image 'trollface.png'
    end
  end

  scenario 'links for speaker are shown only if they exist' do
    speaker = Speaker.create!(:twitter => 'someone', :github => 'something',
                              :site => 'http://someone.com')
    presentation = Presentation.create!(:speakers => [speaker])

    visit programacao_path
    page.should have_css 'img[alt="Twitter"]'
    page.should have_css 'img[alt="Github"]'
    page.should have_css 'img[alt="Site/Blog"]'

    speaker.update_attributes!(:twitter => nil, :github => nil, :site => nil)
    visit programacao_path
    page.should_not have_css 'img[alt="Twitter"]'
    page.should_not have_css 'img[alt="Github"]'
    page.should_not have_css 'img[alt="Site/Blog"]'
  end

  scenario 'speaker photo is loaded from Gravatar if not provided' do
    speaker = Speaker.create!(:email => 'sinistro@nsi.org')
    presentation = Presentation.create!(:speakers => [speaker])

    visit programacao_path
    page.should have_css 'img[src^="http://gravatar.com/avatar.php"]'
  end
end

