# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

ActionMailer::Base.smtp_settings = {
  user_name: 'apikey', # This is the string literal 'apikey', NOT the ID of your API key
  password: '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', # This is the secret sendgrid API key which was issued during API key creation
  domain: 'http://localhost:3000',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
# Below lines are added to stop rails to put field_with_error class when
# errors appear on the screen. We have used custom.css for showing errors 
# in the application
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end

