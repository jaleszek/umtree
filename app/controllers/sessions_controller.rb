class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      redirect_back_or new_user_path
      flash.now[:error] = "Niepoprawne dane logowania"
    else
      sign_in user
      redirect_to user
    end
  
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
