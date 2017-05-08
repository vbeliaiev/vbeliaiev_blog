class UserPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def create?
    !!current_user
  end

  def new?
    !!current_user
  end

  def update?
    destroy?
  end

  def edit?
    destroy?
  end

  def destroy?
    !!current_user
  end

  def show?
    true
  end

  def can_create_new_user?
    !!current_user
  end
end
