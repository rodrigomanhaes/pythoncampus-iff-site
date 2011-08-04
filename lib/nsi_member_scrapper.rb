require 'nokogiri'

class NsiMemberScrapper
  NSI_SITE = 'http://nsi.iff.edu.br'

  def initialize(page_content)
    process(page_content)
  end

  attr_reader :content, :members_css_link

  private

  def process(page_content)
    doc = rip_internal_links(Nokogiri::HTML(page_content))
    @content = externalize_media_links(get_content(doc))
    @members_css_link = NSI_SITE + get_members_href(doc)
  end

  def rip_internal_links(doc)
    ['.member>a', '.member_data>h1>a'].each do |selector|
      doc.css(selector).each {|link| link['href'] = '#' }
    end
    doc
  end

  def get_content(doc)
    doc.at_css('.members_content').to_s
  end

  def externalize_media_links(content)
    content.strip.gsub('src="/site_media', "src=\"#{NSI_SITE}/site_media")
  end

  def get_members_href(doc)
    doc.at_css('link[rel="stylesheet"][href*="members"]')[:href]
  end
end

