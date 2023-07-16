class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user, only: %i[show verify]

  def index
    @users = User.lawyer
  end

  def show
    @similar_users = User.joins(:services).where(services: { id: @user.services.ids }).where.not(id: @user.id)
  end

  def verify
    if @user.update(verified_at: DateTime.now)
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

  private

  def set_user
    @user = User.find(params[:id])
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
end
