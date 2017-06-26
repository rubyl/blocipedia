module WikisHelper
  def user_is_authorized_for_private?
     current_user && current_user.premium? || current_user.admin?
  end
end
