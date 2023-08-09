class ApplicationMailer < ActionMailer::Base
  if Rails.env.production?
    default from: 'Adalat.pk <contact@adalat.pk>'
  else
    default from: 'Adalat.pk Testing <contact@adalat.pk>'
  end
  layout 'mailer'

  def admin_emails
    ENV['LF_ADMIN_EMAILS'].try(:split) || ['contact@adalat.pk']
  end
end
