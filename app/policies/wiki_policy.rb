class WikiPolicy < ApplicationPolicy
  def update_and_destroy?
    user.admin? || record.try(:user) == user
  end
end
