class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?
  add_flash_types :error

  def store_current_location
    store_location_for(:user, request.url)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: devise_account_params)
    devise_parameter_sanitizer.permit(:account_update, keys: devise_account_params)
  end

  def authenticate_admin_user!
    raise SecurityError unless current_user.admin?
  end

  rescue_from SecurityError do
    flash[:error] = 'You are not authorized for this action'
    redirect_to root_path
  end

  private

  def devise_account_params
    [:name, :password, :phone_number, :avatar,
     { user_summary_attributes: %i[id description experience qualification province district tehsil_bar id_card bar_concil_card] },
     { user_services_attributes: %i[id service_id service_proficiency _destroy] }]
  end
end
