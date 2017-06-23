class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user.id)
    else
      redirect_to new_user_url
    end
  end

  def show
    render :show
  end
end
