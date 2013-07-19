# -*- coding: utf-8 -*-
require 'spec_helper'

describe ScoresController do
  describe "GET scores/:iidxid" do
    before do
      User.create(iidxid: "1111-1111", djname: "test")
      xhr :post, :show, iidxid: "1111-1111"
    end

    it "should be success" do
      response.should be_success
    end
  end

  describe "POST 'scores/update'" do
    before do
      Score.all.each do |score|
        score.destroy
      end
      Music.create(level: 12, title: "冥", difficulty: "A", playtype: "SP", notes: 2000)
      xhr :post, :update, iidxid: "1111-1111", title: "冥", playtype: "SP", difficulty: "A", exscore: 3000, bp: 10, clear: "EXH"
    end

    it "should be success" do
      response.should be_success
    end

    it "should create or update the score" do
      @score = Score.where(iidxid: "1111-1111", title: "冥", playtype: "SP", difficulty: "A").first
      @score.should_not == nil
      @score.exscore == 3000
      @score.bp == 1
      @score.clear == "EXH"
    end

    it "should change rate" do
      @score = Score.where(iidxid: "1111-1111", title: "冥", playtype: "SP", difficulty: "A").first
      (@score.rate.to_f * 100).to_i.should > 0
    end
  end
end
