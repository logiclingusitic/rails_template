class V1::Client::SessionsController < ApplicationController

  def new
  end

  def create
    result = AuthenticateUser.call(email: params[:email], password: params[:password])

    if result.success?

      session[:user_id] = result.user.id
      flash[:success] = "You have Successfully Logged In"
      redirect_to root_path

    else
      flash[:danger] = "Either Email or Password is Incorrect"
      redirect_to v1_client_login_path

    end
  end

  def destroy
    session[:user_id] = nil
    flash[:danger] = "Logged Out Successfully!"
    redirect_to v1_client_login_path
  end

end
