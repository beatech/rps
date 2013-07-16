# -*- coding: utf-8 -*-
require 'spec_helper'

describe Score do
  fixtures :scores

  before do
    @score = scores(:valid)
  end

  it "must have :title, :playtype, :difficulty, :iidxid, :exscore, :bp, :rate, :date" do
    [:title, :playtype, :difficulty, :iidxid, :exscore, :bp, :rate, :date].each do |sym|
      invalid_score = @score
      invalid_score[sym] = ""
      invalid_score.should_not be_valid
    end
  end
end
