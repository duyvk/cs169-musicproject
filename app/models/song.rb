class Song < ActiveRecord::Base	
  has_many :playlistsongs
  has_many :playlists, :through => :playlistsongs
  has_many :usersongs
  has_many :users, :through => :usersongs

  def upload(uploadFile)
    if uploadFile == nil
      return false
    end
    if uploadFile['datafile'] == nil || uploadFile['datafile'] == ""
      return false
    end
    
    name = uploadFile['datafile'].original_filename
    directory = "public/songs"
    # create the file path
    if name[-4,4] == ".mp3"
      path = File.join(directory, self.id.to_s + ".mp3")
      # write the file
      File.open(path, "wb") { |f| f.write(uploadFile['datafile'].read) }
      @source = path
      self.save
      return true
    else
      false
    end
  end
  
  def makePlayer
    player_id = "audioplayer" + self.id.to_s + rand(300).to_s
    "<script language=\"JavaScript\" src=\"/player/audio-player.js\"></script>
    <object type=\"application/x-shockwave-flash\" data=\"/player/player.swf\" id=\"" + player_id + "\" height=\"24\" width=\"290\">
    <param name=\"movie\" value=\"/player/player.swf\">
    <param name=\"FlashVars\" value=\"playerID=" + player_id + "&soundFile=/songs/" + self.id.to_s + ".mp3\">
    <param name=\"quality\" value=\"high\">
    <param name=\"menu\" value=\"false\">
    <param name=\"wmode\" value=\"transparent\">
    </object>"
  end
end
