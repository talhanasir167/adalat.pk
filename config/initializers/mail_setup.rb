ActionMailer::Base.smtp_settings = {
  user_name: ENV['SENDMAIL_EMAIL'],
  password: ENV['SENDMAIL_PASSWORD'],
  domain: ENV['MAIL_HOST'],
  address: 'smtp.gmail.com',
  port: '587',
  authentication: :plain,
  enable_starttls_auto: true
}
