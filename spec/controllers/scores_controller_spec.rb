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
      xhr :post, :update, iidxid: "1111-1111", title: "冥", playtype: "SP", difficulty: "A", exscore: "3000", bp: "10", clear: "EH"
    end

    it "should be success" do
      response.should be_success
    end
  end
end
