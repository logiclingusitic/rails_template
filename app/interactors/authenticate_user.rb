class AuthenticateUser
  include Interactor

  def call
    user = User.find_by(email: context.email)

    if user && user.password_digest == context.password

      context.user = user

    else
      context.fail!(message: "authenticate_user.failure!")

    end
  end
end
