# -*- coding: utf-8 -*-
require 'spec_helper'

describe PowersController do
  describe "GET 'powers/update'" do
    before do
      Power.all.each do |power|
        power.destroy
      end
      User.create(iidxid: "2222-2222", djname: "test")
      Score.create(
        iidxid: "2222-2222", title: "冥", playtype: "SP", difficulty: "A",
        exscore: 3999, bp: "1", clear: "EXH", rate: "99.9"
      )
      Music.create(
        title: "冥", level: 12, playtype: "SP", difficulty: "A", notes: 2000
      )
      xhr :get, :update, iidxid: "2222-2222"
    end

    it "should be success" do
      response.should be_success
    end

    it "should create user's score power" do
      @power = Power.where(iidxid: "2222-2222", playtype: "SP").first
      @power.should_not == nil
      @power.score12.to_i.should > 0
    end
  end
end
