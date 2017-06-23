class BandsController < ApplicationController
  before_action :require_user! # STUDY THIS

  def index
    @bands = Band.all
    render :index
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find params[:id]
    if @band.update(band_params)
      redirect_to band_url
    end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
