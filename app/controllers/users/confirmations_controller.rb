module Users
  class ConfirmationsController < Devise::ConfirmationsController
    protected

    def after_confirmation_path_for(resource_name, resource)
      AdminMailer.new_user_notification(resource).deliver_later
      super
    end
  end
end
