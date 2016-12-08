class SessionsController < ApplicationController
  def new
    #render :new
  end

  def create
    login(@user)
    #redirect_to user_url(@user.id)
  end

  def destroy
    logout
    #redirect_to somewhere
  end

  # private

  # def session_params
  #   params.require(:session).permit(:)
  # end
end
