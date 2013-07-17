class Score < ActiveRecord::Base
  validates :title, :presence => true
  validates :playtype, :presence => true
  validates :difficulty, :presence => true
  validates :iidxid, :presence => true
  validates :exscore, :presence => true
  validates :bp, :presence => true
  validates :rate, :presence => true
end
