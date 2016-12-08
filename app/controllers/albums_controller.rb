class AlbumsController < ApplicationController
  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save!
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def update
    @album = Album.find_by(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @albums.errors.full_messages
      render :edit
    end
  end

  def destroy
    @album = Album.find_by(params[:id])
    @album.destroy
    redirect_to albums_url
  end

  private

  def album_params
    params.require(:album).permit(:title, :band_id)
  end
end
