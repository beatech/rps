class Score < ActiveRecord::Base
  validates :title, :presence => true
  validates :playtype, :presence => true
  validates :difficulty, :presence => true
  validates :iidxid, :presence => true
  validates :exscore, :presence => true
  validates :bp, :presence => true
  validates :rate, :presence => true

  def update_rate
    @music = Music.where(title: self.title, playtype: self.playtype, difficulty: self.difficulty).first
    if @music
      score_rate = (100 * self.exscore).to_f / (@music.notes * 2)
      self.rate = "%.2f" % score_rate
      self.save
    end
  end
end
