class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome aboard, #{@user.firstname}!"
      redirect_to root_path
    else
      flash.now[:danger] = "The form contains some errors."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password,
      :password_confirmation)
  end
end
