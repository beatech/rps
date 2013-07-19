class Music < ActiveRecord::Base
  validates :title, :presence => true
  validates :level, :presence => true
  validates :playtype, :presence => true
  validates :difficulty, :presence => true
  validates :notes, :presence => true

  def self.create(args = {})
    if Music.where(title: args[:title], playtype: args[:playtype], difficulty: args[:difficulty]).size == 0
      @music = Music.new(title: args[:title], playtype: args[:playtype], difficulty: args[:difficulty], notes: args[:notes], level: args[:level])
      @music.save
    end
  end
end
