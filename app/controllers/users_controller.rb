class UsersController < ApplicationController
  after_action :verify_authorized, only: %i[new create]

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to root_url, notice: 'User created!'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id]).decorate
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation,
                                 :first_name,
                                 :last_name)
  end
end
