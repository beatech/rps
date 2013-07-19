Music.all.each do |music|
  music.destroy
end

MusicsController.new.update_music_data
