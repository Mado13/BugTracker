class DashboardControllerPolicy
  attr_reader :user, :controller

  # Initialize method of a policy takes 2 arguments, the user and the model,
  # because dashboard controller is just informative and does not have a model
  # so the controller is being passed to preserve the functionality, and therfore
  # policy adn file name were changed accordingly.
  def initialize(user, controller)
    @user = user
    @controller = controller
  end

  def dashboard?
    user.admin?
  end
end
