class AlbumsController < ApplicationController
  before_action :require_user! # STUDY THIS

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new album_params
    if @album.save
      redirect_to band_url(album_params[:band_id])
    end
  end

  def show
    render :show
  end

  private

  def album_params
    params.require(:album).permit(:name, :year, :live, :band_id)
  end
end
