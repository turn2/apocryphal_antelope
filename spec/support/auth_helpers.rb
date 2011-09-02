module AuthHelpers
  def sign_in_as(user)
    @controller.current_user = user
    user
  end

  def sign_in_as_manager
    sign_in_as(Factory(:email_confirmed_user, :role => "manager"))
  end

  def sign_out
    @controller.current_user = nil
  end
end
