class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @services = Service.all
    @users = User.lawyer.first(4)
  end

  def contact
  end
end
