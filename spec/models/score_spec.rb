# -*- coding: utf-8 -*-
require 'spec_helper'

describe Score do
  fixtures :scores

  before do
    @score = scores(:valid)
  end

  it "must have :title, :playtype, :difficulty, :iidxid, :exscore, :bp, :rate" do
    [:title, :playtype, :difficulty, :iidxid, :exscore, :bp, :rate].each do |sym|
      invalid_score = @score.dup
      invalid_score[sym] = ""
      invalid_score.should_not be_valid
    end
  end

  describe "#update_rate" do
    it "should update rate" do
      Music.create(level: 12, title: "冥", difficulty: "A", playtype: "SP", notes: 2000)
      @score = Score.create(iidxid: "1111-1111", title: "冥", playtype: "SP", difficulty: "A", exscore: 3000, bp: 10, clear: "EXH", rate: "0")
      @score.update_rate
      (@score.rate.to_f).to_i.should > 50
    end
  end
end
