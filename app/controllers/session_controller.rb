class SessionController < ApplicationController
  skip_before_action :authenticate_user!

  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in!"
    else
      flash.now[:alert] = "Wrong email or password!"
      render :new
    end
  end
end
