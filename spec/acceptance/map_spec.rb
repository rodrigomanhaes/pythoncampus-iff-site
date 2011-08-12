# coding: utf-8

require 'spec_helper'

feature 'map', :javascript => true do
  before(:all) { Capybara.current_driver = :selenium }
  after(:all) { Capybara.use_default_driver }

  scenario 'loads GoogleMaps map' do
    visit local_path
    within('h1') { page.should have_content 'Localização' }
    page.should have_css '#map_div div'
    page.should have_content 'Marcadores'
    page.should have_content 'Mapa'
    page.should have_content 'Satélite'
  end
end

