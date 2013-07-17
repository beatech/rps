class Power < ActiveRecord::Base
  validates :score8, :presence => true
  validates :score9, :presence => true
  validates :score10, :presence => true
  validates :score11, :presence => true
  validates :score12, :presence => true
  validates :title8, :presence => true
  validates :title9, :presence => true
  validates :title10, :presence => true
  validates :clear11, :presence => true
  validates :clear12, :presence => true
  validates :iidxid, :presence => true
  validates :date, :presence => true
  validates :score_total, :presence => true
  validates :clear_total, :presence => true
end
