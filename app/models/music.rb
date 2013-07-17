class Music < ActiveRecord::Base
  validates :title, :presence => true
  validates :level, :presence => true
  validates :playtype, :presence => true
  validates :difficulty, :presence => true
  validates :notes, :presence => true
end
