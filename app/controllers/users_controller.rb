class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user, only: %i[show verify]

  def index
    @users = User.lawyer
  end

  def show
    @similar_users = User.joins(:services).where(services: { id: @user.services.ids }).where.not(id: @user.id).uniq
  end

  def verify
    if @user.user_summary.update(verified_at: DateTime.now)
      UserMailer.notify_user_about_acount_verification(@user).deliver_later
      redirect_to @user, notice: 'Account has been verified successfully'
    else
      redirect_to root_path, error: 'There is a problem updating account'
    end
  end

  def search
    @users = User.lawyer
    name_search(params[:name_search]) if params[:name_search].present?
    service_search(params[:service_id]) if params[:service_id].present?
    tehsil_bar_search(params[:tehsil_bar]) if params[:tehsil_bar].present?
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('users-list', partial: 'users/user', collection: @users, as: :user)
      end
    end
  end

  def contact_admin
    set_contact_params
    if verify_contact_params
      send_contact_mail
      flash.now[:notice] = 'Thank you for using Adalat.pk, We will come back to you soon!'
      handle_successful_admin_contact
    else
      handle_contact_failure
    end
  end

  def contact_lawyer
    set_contact_params
    @lawyer = User.find(params[:user_id]) if params[:user_id].present?
    if verify_contact_params
      send_contact_mail
      flash.now[:notice] = 'Thank you for using Adalat.pk, We will come back to you soon!'
      handle_successful_lawyer_contact
    else
      handle_contact_failure
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to '/404'
  end

  def name_search(name)
    @users = @users.where('users.name ILIKE ?', "%#{name}%")
  end

  def service_search(service_id)
    @users = @users.joins(:services).where(services: { id: service_id })
  end

  def tehsil_bar_search(tehsil_bar)
    @users = @users.joins(:user_summary).where('user_summaries.tehsil_bar ILIKE ?', "%#{tehsil_bar}%")
  end

  def handle_successful_admin_contact
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('contact-page', partial: 'pages/home_partials/contact_us'),
          turbo_stream.prepend('body_tag', partial: 'shared/toast')
        ]
      end
    end
  end

  def handle_successful_lawyer_contact
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('contact-page', partial: 'users/guest_user_contact_form',
                                              locals: { user_id: @lawyer&.id }),
          turbo_stream.prepend('body_tag', partial: 'shared/toast')
        ]
      end
    end
  end

  def handle_contact_failure
    flash.now[:error] = 'There is a problem receiving your message'
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.prepend('body_tag', partial: 'shared/toast')
      end
    end
  end

  def set_contact_params
    @name = params[:name]
    @email = params[:email]
    @mobile_number = params[:mobile_number]
    @messages = params[:feedback]
  end

  def send_contact_mail
    if @lawyer.present?
      AdminMailer.new_message_for_lawyer(@name, @email, @mobile_number, @messages, @lawyer).deliver_later
    else
      AdminMailer.new_message(@name, @email, @mobile_number, @messages).deliver_later
    end
  end

  def verify_contact_params
    @name.present? && @email.present? && @mobile_number.present? && @messages.present?
  end
end
