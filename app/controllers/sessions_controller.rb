class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:proceed_path]
        proceed_path = session[:proceed_path]
        session[:proceed_path] = nil
        redirect_to proceed_path
      else
        redirect_to user
      end
    else
      redirect_to :back, notice: "wrong username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path
  end
end
