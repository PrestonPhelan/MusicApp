class UsersController < ApplicationController
  def new
    @user = User.new
    #render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #Log In
      #redirect_to #index
    else
      flash.now[:errors] = "Invalid username/password"
      #render :new
    end
  end

  def show
    #render :show
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest, :session_token)
  end
end
