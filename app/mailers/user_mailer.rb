class UserMailer < ApplicationMailer
  def notify_user_about_acount_verification(user)
    @user = user
    @user_profile = "#{ENV['RAILS_APP_URL']}users/#{user.id}"

    mail(to: @user.email, subject: 'Adalat.pk: Account Verification')
  end
end
