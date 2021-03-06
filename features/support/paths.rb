module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the signup page/
      '/signup'
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))
    
    when /the upload song page/
      '/songs/new'

    when /the profile for "(.*)"/
       @user = User.find_by_name($1)
      '/users/show/'+@user.id.to_s

    when /the profile page of user "(.*)"/
       @user = User.find_by_name($1)
      '/users/show/'+@user.id.to_s

    when /the edit user page for "(.*)"/
       @user = User.find_by_name($1)
      '/users/edit/'+@user.id.to_s
    when /the login page/
       '/login'
    when /the logout page/
       '/logout'
    when /the Make new playlist page/
       '/Playlists/new'
       
    when /the rating page for the song "([^"]*)"/
      @song = Song.find_by_name($1)
      '/rating/song/new/'+@song.id.to_s
      
    when /the rating page for the playlist "([^"]*)"/
      @playlist = Playlist.find_by_name($1)
      '/rating/playlist/new/'+@playlist.id.to_s

    when /the show page for the song "([^"]*)"/
      @song = Song.find_by_name($1)
      '/songs/show/'+@song.id.to_s

    when /the home page/
       '/'

    when /the browse page/
       '/browse'
    
    when /the comment page for the song "([^"]*)"/
        @song = Song.find_by_name($1)
        '/comment/song/new/'+@song.id.to_s

    when /the comment page for the playlist "([^"]*)"/
        @playlist = Playlist.find_by_name($1)
        '/comment/playlist/new/'+@playlist.id.to_s

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
