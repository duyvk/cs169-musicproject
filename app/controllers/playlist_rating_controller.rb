class PlaylistRatingController < ApplicationController
  before_filter :require_user

  def new
    @playlist_rating = PlaylistRating.new
    @playlist = Playlist.find(params[:playlist_id])
    respond_to do |format|
      format.html
      format.xml   { render :xml => @playlist_rating }
    end
  end

  def create
    @playlist_rating = PlaylistRating.find_by_user_id current_user.id
    if @playlist_rating == nil
      @playlist_rating = PlaylistRating.new(params[:playlist_rating])
    else
      @playlist_rating.update_attributes(params[:playlist_rating])
    end
    @playlist_rating.user_id = current_user.id
    @playlist_rating.playlist_id = params[:playlist_id]
    @playlist = Playlist.find(params[:playlist_id])
    @confirm = @playlist_rating.save
	if @confirm
      @playlist.updateRating
    else
      @playlist.updateRating
      PlaylistRating.delete(@playlist_rating.id)
    end
  end
end
