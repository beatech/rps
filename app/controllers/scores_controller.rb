class ScoresController < ApplicationController
  def show
    @user = User.where(iidxid: params[:iidxid]).first
    redirect_to root_url if @user == nil

    @musics = Hash.new
    ["SP", "DP"].each do |playtype|
      @musics[playtype] = Array.new
      (1..12).each do |level|
        @musics[playtype][level] = Music.where(playtype: playtype, level: level)
      end
    end
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
