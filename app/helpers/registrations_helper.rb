module RegistrationsHelper
  def user_is_authorized_for_upgrade?
     current_user && !current_user.premium?
  end

  def user_is_authorized_for_downgrade?
    current_user && current_user.premium?
  end
end
