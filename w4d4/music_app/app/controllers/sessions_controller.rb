class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params[:email], user_params[:password])

    if user.nil?
      redirect_to session_url
    else
      log_in_user!(user)
      redirect_to bands_url
    end
  end

  def destroy
    log_out_user!(current_user)
    redirect_to bands_url
  end
end
