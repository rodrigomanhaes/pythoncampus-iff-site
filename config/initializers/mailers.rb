config_file = File.join(::Rails.root, 'config', 'mail.yml')
mail = File.exists?(config_file) ? YAML.load(File.read(config_file)) : {}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.delivery_method = :test if Rails.env.test?
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address        => mail['address'],
  :port           => mail['port'].to_i,
  :domain         => mail['domain'],
  :authentication => mail['authentication'].try(:to_sym),
  :user_name      => mail['user_name'],
  :password       => mail['password']
}

