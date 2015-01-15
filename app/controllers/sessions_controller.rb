class SessionsController < ApplicationController
  def new

  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Login successful'
      redirect_to user_path(@user)
    else
      flash[:error] = 'Invalid Login'
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:notice] = 'Logout was successful'
    redirect_to login_path
  end
end
