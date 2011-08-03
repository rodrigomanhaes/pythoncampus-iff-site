class Speaker < ActiveRecord::Base
  has_attached_file :photo

  def twitter_link
    return nil if twitter.blank?
    twitter =~ /^\@?(.+)$/
    "http://twitter.com/#{$1}"
  end

  def github_link
    return nil if github.blank?
    "https://github.com/#{github}"
  end
end

