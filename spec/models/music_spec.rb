# -*- coding: utf-8 -*-
require 'spec_helper'

describe Music do
  fixtures :musics

  before do
    @music = musics(:valid)
  end

  it "must have :title, :level, :playtype, :difficulty, :notes" do
    [:title, :level, :playtype, :difficulty, :notes].each do |sym|
      invalid_music = @music.dup
      invalid_music[sym] = ""
      invalid_music.should_not be_valid
    end
  end

  describe ".create" do
    it "should create a music, and should not create duplicate musics" do
      Music.create(level: 12, title: "冥", difficulty: "A", playtype: "SP", notes: 2000)
      Music.create(level: 12, title: "冥", difficulty: "A", playtype: "SP", notes: 2000)
      Music.where(title: "冥", playtype: "SP", difficulty: "A").size.should == 1
    end
  end
end
