module PagesHelper
  def set_navbar_user_url
    user_signed_in? && current_user.user_avatar || 'user_default_avatar.png'
  end

  def add_style(element, style)
    element.insert(-7, style)
  end
end
