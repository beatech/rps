class ScoresController < ApplicationController
  def show
    @user = User.where(iidxid: params[:iidxid]).first
    redirect_to root_url if @user == nil
    @musics = Hash.new
    ["SP", "DP"].each do |playtype|
      @musics[playtype] = Hash.new
      (1..12).each do |level|
        @musics[playtype][level] = Music.where(playtype: playtype, level: level)
          .map { |music| Score.where(iidxid: params[:iidxid], title: music[:title], playtype: playtype, difficulty: music[:difficulty]) }
        @musics[playtype][level].sort! { |a, b| b[:rate].to_i <=> a[:rate].to_i }
      end
    end
  end

  def update
    args = Hash.new
    [:iidxid, :title, :playtype, :difficulty].each do |symbol|
      args[symbol] = params[symbol.to_s]
    end
    #@score = Score.new(args)
    #@score.update(exscore: params["exscore"], bp: params["bp"], clear: params["clear"])
    #powers_controller = PowersController.new
    #powers_controller.update(args[:iidxid])
    render text: "update succeeded"
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
