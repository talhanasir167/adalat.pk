class AdminMailer < ApplicationMailer
  def new_user_notification(user)
    @admin = User.admin.first
    @user = user
    @user_profile = "#{ENV['RAILS_APP_URL']}users/#{user.id}"
    @verify_url = "#{ENV['RAILS_APP_URL']}admin/users/#{user.id}/verify"

    mail(to: User.admin.pluck(:email), subject: 'Law Firm: New account on Law Firm')
  end
end
