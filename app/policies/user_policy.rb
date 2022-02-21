class UserPolicy < ApplicationPolicy
  def new?
    user.admin?
  end

  def create?
    new?
  end

  # User can being eddited only by an admin or by the user itself
  def edit?
    user.admin? || record.id == user.id
  end

  def update?
    edit?
  end
end
