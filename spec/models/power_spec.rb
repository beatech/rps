require 'spec_helper'

describe Power do
  fixtures :powers

  before do
    @power = powers(:valid)
  end

  it "must have :score8, :score9, :score10, :score11, :score12" do
    (8..12).each do |level|
      sym = "score#{level}".to_sym
      invalid_power = @power
      invalid_power[sym] = ""
      invalid_power.should_not be_valid
    end
  end

  it "must have :title8, :title9, :title10, :clear11, :clear12" do
    (8..10).each do |level|
      sym = "title#{level}".to_sym
      invalid_power = @power
      invalid_power[sym] = ""
      invalid_power.should_not be_valid
    end

    (11..12).each do |level|
      sym = "clear#{level}".to_sym
      invalid_power = @power
      invalid_power[sym] = ""
      invalid_power.should_not be_valid
    end
  end

  it "must have :iidxid, :date, :score_total, :clear_total" do
    [:iidxid, :date, :score_total, :clear_total].each do |sym|
      invalid_power = @power
      invalid_power[sym] = ""
      invalid_power.should_not be_valid
    end
  end
end
