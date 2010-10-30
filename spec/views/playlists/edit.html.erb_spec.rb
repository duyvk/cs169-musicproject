require 'spec_helper'

describe "/playlists/edit.html.erb" do
  include PlaylistsHelper

  before(:each) do
    assigns[:playlist] = @playlist = stub_model(Playlist,
      :new_record? => false,
      :name => "value for name",
      :user_id => 1,
      :rating => 1.5,
      :description => "value for description"
    )
  end

  it "renders the edit playlist form" do
    render

    response.should have_tag("form[action=#{playlist_path(@playlist)}][method=post]") do
      with_tag('input#playlist_name[name=?]', "playlist[name]")
      with_tag('input#playlist_user_id[name=?]', "playlist[user_id]")
      with_tag('input#playlist_rating[name=?]', "playlist[rating]")
      with_tag('textarea#playlist_description[name=?]', "playlist[description]")
    end
  end
end
