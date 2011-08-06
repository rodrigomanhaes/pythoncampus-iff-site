def create_short_course(options)
  presentation = Factory.create(:short_course, :title => options[:presentation])
  attendee = Attendee.find_by_name(options[:attendee]) || Factory.create(:attendee, :name => options[:attendee])
  Registration.create! :presentation => presentation, :attendee => attendee
end

def login(user = nil)
  user ||= Factory.create(:user)
  visit '/users/sign_in'
  fill_in 'Email', :with => user.email
  fill_in 'Password', :with => 'topsecret'
  click_button 'Sign in'
end

