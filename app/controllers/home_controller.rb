require 'open-uri'

class HomeController < ApplicationController
  def index
  end

  def under_construction
  end

  def map
  end

  def team
    scrapper = NsiMemberScrapper.new(open("#{NsiMemberScrapper::NSI_SITE}/membros"))
    @content, @members_css_link = scrapper.content, scrapper.members_css_link
  end
end

