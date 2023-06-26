class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user
  def show; end

  def verify
    @user.update(verified_at: DateTime.now)
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to '/404'
  end
end
