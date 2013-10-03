class ScoresController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: Score.all }
    end
  end

  def show
    @user = User.find_by_iidxid(params[:iidxid])
    redirect_to root_url unless @user

    music_datas = Music.all
    @musics = Hash.new
    music_datas.each do |music_data|
      @musics[music_data.playtype] = Array.new unless @musics[music_data.playtype]
      @musics[music_data.playtype][music_data.level] = Array.new unless @musics[music_data.playtype][music_data.level]
      @musics[music_data.playtype][music_data.level].push(music_data)
    end

    score_datas = Score.where(iidxid: @user[:iidxid])
    @scores = Hash.new
    score_datas.each do |score_data|
      @scores[score_data.playtype] = Hash.new unless @scores[score_data.playtype]
      @scores[score_data.playtype][score_data.title] = Hash.new unless @scores[score_data.playtype][score_data.title]
      @scores[score_data.playtype][score_data.title][score_data.difficulty] = score_data
    end
  end

  def show_all
    @user = User.find_by_iidxid(params[:iidxid])
    @scores = Score.where(iidxid: @user[:iidxid])
  end

  def update
    begin
      params[:clear] = "EXH" if params[:clear] == "EH"
      @score = Score.where(
        iidxid: params[:iidxid], title: params[:title], playtype: params[:playtype], difficulty: params[:difficulty]
      ).first
      @score ||= Score.create(
        iidxid: params[:iidxid], title: params[:title], playtype: params[:playtype], difficulty: params[:difficulty],
        exscore: 0, bp: "-", clear: "F", rate: "0"
      )
      @score.update_attributes(exscore: params[:exscore], bp: params[:bp], clear: params[:clear])
      @score.update_rate
      render text: "update succeeded"
    rescue
      render text: "failed to update"
    end
  end

  def update_all_rate
    @users = User.all
    @users.each do |user|
      ["SP", "DP"].each do |playtype|
        (1..12).each do |level|
          @musics = Music.where(playtype: playtype, level: level)
          @musics.each do |music|
            score_hash = Score.where(iidxid: user[:iidxid], title: music[:title], playtype: playtype, difficulty: music[:difficulty])
            score = Score.new(iidxid: user[:iidxid], title: music[:title], playtype: playtype, difficulty: music[:difficulty])
            score.update_rate(score_hash)
          end
        end
      end
    end
    @scores = Score
  end
end
