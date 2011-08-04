require 'digest'

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

  def photo_link
    return photo.url if photo.exists?
    gravatar_link
  end

  private

  def gravatar_link
    return nil if email.blank?
    "http://gravatar.com/avatar.php?gravatar_id=#{Digest::MD5.hexdigest email}"
  end
end

