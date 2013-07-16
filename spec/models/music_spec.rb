# -*- coding: utf-8 -*-
require 'spec_helper'

describe Music do
  fixtures :musics

  before do
    @music = musics(:valid)
  end

  it "must have :title, :level, :playtype, :difficulty, :notes" do
    [:title, :level, :playtype, :difficulty, :notes].each do |sym|
      invalid_music = @music
      invalid_music[sym] = ""
      invalid_music.should_not be_valid
    end
  end
end
