class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user
    else
      redirect_to :back, notice: "wrong username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to events_path
  end
end
