config_file = File.join(::Rails.root, 'config', 'mail.yml')
mail = File.exists?(config_file) ? YAML.load(File.read(config_file)) : {'password' => ''}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.delivery_method = :test if Rails.env.test?
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

