module PagesHelper
  def set_navbar_user_url
    user_signed_in? && current_user.user_avatar || 'user_default_avatar.png'
  end
end
