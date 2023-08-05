class AdminMailer < ApplicationMailer
  def new_user_notification(user)
    @admin = User.admin.first
    @user = user
    @user_profile = "#{ENV['RAILS_APP_URL']}admin/users/#{user.id}"
    @verify_url = "#{ENV['RAILS_APP_URL']}users/#{user.id}/verify"

    mail(to: User.admin.pluck(:email), subject: 'Adalat.pk: New account on Adalat.pk')
  end

  def new_message(name, email, mobile_number, msg)
    @name = name
    @email = email
    @mobile_number = mobile_number
    @message = msg
    @admin = User.admin.first

    mail(to: User.admin.pluck(:email), subject: 'Adalat.pk: New message from Client')
  end

  def new_message_for_lawyer(name, email, mobile_number, msg, lawyer)
    @name = name
    @email = email
    @mobile_number = mobile_number
    @message = msg
    @admin = User.admin.first
    @lawyer = lawyer

    mail(to: User.admin.pluck(:email), subject: 'Adalat.pk: New message for lawyer')
  end
end
