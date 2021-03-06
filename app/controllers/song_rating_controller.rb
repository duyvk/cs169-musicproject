class SongRatingController < ApplicationController
  before_filter :require_user

  def new
    @song_rating = SongRating.new
    @song = Song.find(params[:song_id])
    respond_to do |format|
       format.html
       format.xml   { render :xml => @song_rating }
    end
  end

  def create
    @song_rating = SongRating.find_by_user_id current_user.id
    if @song_rating == nil
      @song_rating = SongRating.new(params[:song_rating])
    else
      @song_rating.update_attributes(params[:song_rating])
    end
    @song_rating.user_id = current_user.id
    @song_rating.song_id = params[:song_id]
    @song = Song.find(params[:song_id])
    @confirm = @song_rating.save
	if @confirm
      @song.updateRating
    else
      @song.updateRating
      SongRating.delete(@song_rating.id)
    end
  end
end
