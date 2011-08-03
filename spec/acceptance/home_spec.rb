# coding: utf-8

require 'spec_helper'

feature 'home page' do
  scenario 'shows welcome info' do
    visit root_path
    page.should have_content 'PythOnCampus é uma caravana de tecnologia'
  end
end

