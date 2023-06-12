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

  private

  def devise_account_params
    %i[first_name middle_name last_name password description experience qualification province district tehsil_bar]
  end
end
