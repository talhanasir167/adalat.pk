module Users
  class RegistrationsController < Devise::RegistrationsController

    protected

    def sign_up(_resource_name, resource)
      AdminMailer.new_user_notification(resource).deliver_later if User.admin.exists?
      super
    end
  end
end
