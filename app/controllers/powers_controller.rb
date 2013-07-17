# -*- coding: utf-8 -*-
class PowersController < ApplicationController
  def update
    #update_power(params[:iidxid])
    render text: "update succeeded"
  end

  def update_power(iidxid)
    hash = Hash.new
    hash[:iidxid] = iidxid
    ["SP", "DP"].each do |playtype|
      [8, 9, 10].each do |level|
        score_sym = (playtype.downcase + level.to_s + "score").to_sym
        title_sym = (playtype.downcase + level.to_s + "title").to_sym
        hash[score_sym], hash[title_sym] = single_score_power(iidxid, playtype, level)
      end
      [11, 12].each do |level|
        score_sym = (playtype.downcase + level.to_s + "score").to_sym
        hash[score_sym] = total_score_power(iidxid, playtype, level)
        clear_sym = (playtype.downcase + level.to_s + "clear").to_sym
        hash[clear_sym] = clear_power(iidxid, playtype, level)
      end
      total_sym = (playtype.downcase + "total").to_sym
      hash[total_sym] = 0
      (8..12).each do |level|
        score_sym = (playtype.downcase + level.to_s + "score").to_sym
        hash[total_sym] += hash[score_sym]
      end
      cleartotal_sym = (playtype.downcase + "cleartotal").to_sym
      hash[cleartotal_sym] = 0
      (11..12).each do |level|
        clear_sym = (playtype.downcase + level.to_s + "clear").to_sym
        hash[cleartotal_sym] += hash[clear_sym].to_f
      end
    end
    #Power.update(hash)
  end

  def update_all
    @users = User.all
    @users.each do |user|
      update_power(user[:iidxid])
    end
    render text: "update succeeded"
  end

  def clear_power(iidxid, playtype, level)
    # 基礎点:30 * (FC+EXH+H)^2 * 5^((FC+EXH)^2) * 5^(FC^2)
    # 点数:基礎点 ^ ( (1.1 + 1/6) - (5^(BP/100))/6 ) - lv12
    base = case level
           when 11 then 40
           when 12 then 250
           end
    fc_num = 0
    fc_rate = 0
    exh_num = 0
    exh_rate = 0
    h_num = 0
    h_rate = 0
    bp_sum = 0
    score_num = 0
    lamp_num = 0
    bp_ave = 0
    Music.where(playtype: playtype, level: level.to_s).each do |music|
      score = Score.where(iidxid: iidxid, title: music[:title], playtype: playtype, difficulty: music[:difficulty])
      fc_num += 1 if score[:clear] == "FC"
      exh_num += 1 if score[:clear] == "EXH"
      h_num += 1 if score[:clear] == "H"
      lamp_num += 1
      if score[:bp] != "-"
        bp_sum += score[:bp].to_i
        score_num += 1
      end
    end

    bp_ave = bp_sum.to_f / score_num if score_num > 0
    if lamp_num > 0
      fc_rate = fc_num.to_f / lamp_num
      exh_rate = exh_num.to_f / lamp_num
      h_rate = h_num.to_f / lamp_num
    end
    k = case level
        when 11 then (1.1 + 1.0/6) - ((1.14**(bp_ave / 2)) / 6)
        when 12 then (1.1 + 1.0/6) - ((5**(bp_ave / 100)) / 6)
        end
    base_point = base * (fc_rate + exh_rate + h_rate)**2 * 5**((fc_rate + exh_rate)**2) * 5**(fc_rate**2)
    if base_point > 0
      clear_power = base_point**k
    else
      clear_power = 0
    end

    # catch underflow
    if clear_power.to_i > 100000
      clear_power = 0
    end

    # For debug
    # raise "IIDXID:"+iidxid+",SCORE_NUM:"+score_num.to_s+",LAMP_NUM:"+lamp_num.to_s+",FC_NUM:"+fc_num.to_s+
    #   ",EXH_NUM:"+exh_num.to_s+",H_NUM:"+h_num.to_s+",FC_RATE:"+fc_rate.to_s+",EXH_RATE:"+exh_rate.to_s+",H_RATE:"+h_rate.to_s+
    #   ",BP_AVE:"+bp_ave.to_s+",BASE_POINT:"+base_point.to_s+",K:"+k.to_s+",CLEAR_POWER:"+(clear_power).to_s

    clear_power
  end

  def single_score_power(iidxid, playtype, level)
    title = "-"
    max_rate = 0
    Music.where(playtype: playtype, level: level.to_s).each do |music|
      score = Score.where(iidxid: iidxid, title: music[:title], playtype: playtype, difficulty: music[:difficulty])
      if max_rate < score[:rate].to_f
        title = music[:title]
        max_rate = score[:rate].to_f
      end
    end
    base = case level
           when 8 then 280
           when 9 then 330
           when 10 then 390
           end

    mas_rate = 99.9 if max_rate == 100
    score_power = base * (0.6 ** (100 - max_rate))
    [score_power, title]
  end

  def total_score_power(iidxid, playtype, level)
    base = case level
           when 11 then 50
           when 12 then 200
           end
    score_rate = 0
    score_num = 0
    aaa_num = 0
    aa_num = 0
    rate_sum = 0
    Music.where(playtype: playtype, level: level.to_s).each do |music|
      score = Score.where(iidxid: iidxid, title: music[:title], playtype: playtype, difficulty: music[:difficulty])
      if score[:rate].to_f > 0
        score_num += 1
        rate_sum += score[:rate].to_f
        if score[:rate].to_f > 88.8
          aaa_num += 1
        elsif score[:rate].to_f > 77.7
          aa_num += 1
        end
      end
    end

    score_rate = rate_sum / score_num if score_num > 0
    score_rate /= 100
    if 1 > score_rate && score_rate > 0
      pika_great = (score_rate - 0.5) / (1 - score_rate)
      score_power = base * (aaa_num.to_f / score_num + 1) * ((aaa_num + aa_num).to_f / score_num) * pika_great;
    else
      score_power = 0
    end
    score_power
  end
end
