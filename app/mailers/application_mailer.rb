class ApplicationMailer < ActionMailer::Base
  if Rails.env.production?
    default from: 'Law Firm <usman.zulfiqar065@gmail.com>'
  else
    default from: 'Law Firm Testing <usman.zulfiqar065@gmail.com>'
  end
  layout 'mailer'

  def admin_emails
    ENV['LF_ADMIN_EMAILS'].try(:split) || ['usman.zulfiqar065@gmail.com']
  end
end
