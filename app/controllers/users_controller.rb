class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user, only: %i[show verify]

  def index
    @users = User.lawyer
  end

  def show; end

  def verify
    if @user.update(verified_at: DateTime.now)
      UserMailer.notify_user_about_acount_verification(@user).deliver_later
      redirect_to @user, notice: 'Account has been verified successfully'
    else
      redirect_to root_path, error: 'There is a problem updating account'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to '/404'
  end
end
