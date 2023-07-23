class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @services = Service.first(3)
    @users = User.lawyer.first(4)
  end

  def about
    @gallery_images = GalleryImage.all
  end

  def contact; end

  def faqs; end
end
