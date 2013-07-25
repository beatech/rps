# -*- coding: utf-8 -*-
require 'spec_helper'

describe MusicsController do
  describe "GET 'musics'" do
    before do
      xhr :get, :index
    end

    it "should be success" do
      response.should be_success
    end
  end

  describe "GET 'musics/diff'" do
    before do
      xhr :get, :diff, iidxid: "1111-1111"
    end

    it "should be success" do
      response.should be_success
    end
  end
end
