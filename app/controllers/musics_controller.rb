require 'kconv'

class MusicsController < ApplicationController
  include HTTParty

  def index
    @musics = Hash.new
    ["SP", "DP"].each do |playtype|
      @musics[playtype] = Hash.new
      (1..12).each do |level|
        @musics[playtype][level] = Music.where(playtype: playtype, level: level)
      end
    end
  end

  def new
    @music = Music.new
  end

  def edit
    @music = Music.find(params[:id])
  end

  def create
    @music = Music.new
    [:title, :playtype, :difficulty, :level, :notes].each do |sym|
      @music[sym] = params[:music][sym]
    end
    @music.save
    redirect_to root_url + 'musics'
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    redirect_to root_url + 'musics'
  end

  def update
    @music = Music.find(params[:music][:id])
    @music.title = params[:music][:title]
    @music.notes = params[:music][:notes]
    @music.save
    redirect_to root_url + 'musics'
  end

  def update_music_data
    music_list = textage_music_list
    music_list.each do |music|
      next if music[:version] == "0"
      music = textage_music_data(music)
      [:spn, :sph, :spa, :dpn, :dph, :dpa].each do |symbol|
        playtype = case symbol
                   when :spn, :sph, :spa then "SP"
                   when :dpn, :dph, :dpa then "DP"
                   end
        difficulty = case symbol
                     when :spn, :dpn then "N"
                     when :sph, :dph then "H"
                     when :spa, :dpa then "A"
                     end
        if music[symbol].has_key?(:level)
          level = case music[symbol][:level]
                  when "A" then "10"
                  when "B" then "11"
                  when "C" then "12"
                  else music[symbol][:level]
                  end
        else
          level = "0"
        end

        notes = music[symbol][:notes]
        Music.create(level: level, title: music[:title], difficulty: difficulty, playtype: playtype, notes: notes)
      end
    end
  end

  # Thanks for TexTage(http://textage.cc/)
  def textage_music_list
    ignore_ids = ["pinkrose", "2tribe4k", "scripted", "tripping", "due_tmrw", "rockit", "_59_2nd", "g_knight", "lubuchi", "kecak", "logic", "lvdream"]
    music_list = Array.new
    script = get("http://textage.cc/score/actbl.js")
    script.each_line do |line|
      if line =~ /'(.+)'\s+:\[(.+)\],/
        next if ignore_ids.include?($1)
        numbers = $2.split(',')
        music_list += [{
            id: $1,
            version: textage_id_to_version($1),
            spn: { level: numbers[5] },
            sph: { level: numbers[7] },
            spa: { level: numbers[9] },
            dpn: { level: numbers[15] },
            dph: { level: numbers[17] },
            dpa: { level: numbers[19] }
        }]
      end
    end
    music_list
  end

  def textage_music_data(music)
    a_count = 0
    l_count = 0
    script = get("http://textage.cc/score/#{music[:version]}/#{music[:id]}.html")
    script = script.kconv(Kconv::UTF8, Kconv::SJIS)
    script.each_line do |line|
      case line
      when /genre=".+";title="([^=]+)";/
        music[:title] = $1.gsub(/\\"/, '"')
      when /if\(a\){notes=([0-9]+);/
        if a_count == 0
          music[:spa][:notes] = $1
        else
          music[:dpa][:notes] = $1
        end
        a_count += 1
      when /if\(k\){notes=([0-9]+);/
        music[:sph][:notes] = $1
      when /if\(l\){notes=([0-9]+);/
        if l_count == 0
          music[:spn][:notes] = $1
        else
          music[:dpn][:notes] = $1
        end
        l_count += 1
      when /else{notes=([0-9]+);/
        music[:dph][:notes] = $1
      end
    end
    music
  end

  def textage_id_to_version(id)
    @script ||= get("http://textage.cc/score/titletbl.js")
    @script.each_line do |line|
      if line =~ /#{id}'\s*:\[([0-9]+)/
        return $1
      end
    end
  end

  def get(args)
    self.class.get(args)
  end

  def diff
    @djname = User.where(iidxid: params[:iidxid]).first.djname
    musics = Music.all
    scores = Score.where(iidxid: params[:iidxid])

    @nodatas = Array.new
    scores.each do |score|
      next if has_music?(@nodatas, score)
      @nodatas.push(score) if has_music?(musics, score) == false
    end

    @noplays = Array.new
    musics.each do |music|
      ;
    end
  end

  def has_music?(musics, score)
    musics.each do |music|
      if music.title == score.title && music.playtype == score.playtype && music.difficulty == score.difficulty
        return true
      end
    end
    false
  end
end
