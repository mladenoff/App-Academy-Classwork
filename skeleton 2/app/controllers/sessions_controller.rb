class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      redirect_to session_url
    else
      login!(user)
      redirect_to cats_url
    end
  end

end
