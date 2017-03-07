class SessionsController < ApplicationController

  def new
  end

  def create
    if login(params[:email], params[:password])
      redirect_to root_path, notice: 'Logged in successfully'
    else
      redirect_to sign_in_path, alert: 'Email or password invalid'
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'Logged out successfully'
  end

end
