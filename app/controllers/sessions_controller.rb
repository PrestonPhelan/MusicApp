class SessionsController < ApplicationController
  include ApplicationHelper
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid username/password combination"]
      render :new
    end
  end

  def destroy
    logout(current_user)
    redirect_to new_user_url
  end

  # private

  # def session_params
  #   params.require(:session).permit(:)
  # end
end
