mail = YAML.load(File.read(File.join(::Rails.root, 'config', 'mail.yml')))

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,  #this is the important s#it!
  :address        => 'smtp.gmail.com',
  :port           => 587,
  :domain         => 'gmail.com',
  :authentication => :plain,
  :user_name      => 'pythoncampus2011@gmail.com',
  :password       => mail['password']
}

