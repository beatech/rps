# -*- coding: utf-8 -*-
class PowersController < ApplicationController
  def update
    update_power(params[:iidxid])
    render text: "update succeeded"
  end

  def update_power(iidxid)
    hash = Hash.new
    hash[:iidxid] = iidxid
    ["SP", "DP"].each do |playtype|
      [8, 9, 10].each do |level|
        score_sym = "score#{level}".to_sym
        title_sym = "title#{level}".to_sym
        hash[score_sym], hash[title_sym] = single_score_power(iidxid, playtype, level)
      end

      [11, 12].each do |level|
        score_sym = "score#{level}".to_sym
        clear_sym = "clear#{level}".to_sym
        hash[clear_sym] = clear_power(iidxid, playtype, level)
        hash[score_sym] = total_score_power(iidxid, playtype, level)
      end

      score_total = 0
      (8..12).each do |level|
        score_sym = "score#{level}".to_sym
        score_total += hash[score_sym].to_f
      end
      hash[:score_total] = score_total.to_s

      clear_total = 0
      (11..12).each do |level|
        clear_sym = "clear#{level}".to_sym
        clear_total += hash[clear_sym].to_f
      end
      hash[:clear_total] = clear_total.to_s

      @power = Power.where(iidxid: iidxid, playtype: playtype).first
      @power ||= Power.create(
        iidxid: iidxid,
        playtype: playtype,
        score8: "0.00",
        score9: "0.00",
        score10: "0.00",
        score11: "0.00",
        score12: "0.00",
        title8: "-",
        title9: "-",
        title10: "-",
        clear11: "0.00",
        clear12: "0.00",
        date: Date.today,
        score_total: "0.00",
        clear_total: "0.00"
      )
      @power.update_attributes(hash)
    end
  end

  def update_all
    @users = User.all
    @users.each do |user|
      update_power(user[:iidxid])
      puts "Completed: #{user[:iidxid]}"
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

    scores = Score.where(iidxid: iidxid)
    Music.where(playtype: playtype, level: level.to_s).each do |music|
      score = scores.select{|x| x.title == music[:title] && x.playtype == playtype && x.difficulty == music[:difficulty] }.first
      next unless score
      fc_num += 1 if score[:clear] == "FC"
      exh_num += 1 if score[:clear] == "EXH"
      h_num += 1 if score[:clear] == "H"
      lamp_num += 1 if score[:clear] != "-"
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

    # catch underflow
    if (base_point * 100).to_i > 100
      clear_power = base_point**k
    else
      clear_power = 0
    end

    # catch overflow
    begin
      if clear_power.to_i > 100000
        clear_power = 0
      end
    rescue
      clear_power = 0
    end

    # For debug
    # if level == 11
    #   raise "LEVEL:"+level.to_s+"\n,IIDXID:"+iidxid+",\nSCORE_NUM:"+score_num.to_s+",\nLAMP_NUM:"+lamp_num.to_s+",\nFC_NUM:"+fc_num.to_s+
    #   "\n,EXH_NUM:"+exh_num.to_s+"\n,H_NUM:"+h_num.to_s+"\n,FC_RATE:"+fc_rate.to_s+"\n,EXH_RATE:"+exh_rate.to_s+"\n,H_RATE:"+h_rate.to_s+
    #   "\n,BP_AVE:"+bp_ave.to_s+"\n,BASE_POINT:"+base_point.to_s+"\n,K:"+k.to_s+"\n,CLEAR_POWER:"+("%.2f" % clear_power)
    # end


    "%.2f" % clear_power
  end

  def single_score_power(iidxid, playtype, level)
    title = "-"
    max_rate = 0
    scores = Score.where(iidxid: iidxid)
    Music.where(playtype: playtype, level: level.to_s).each do |music|
      #score = Score.where(iidxid: iidxid, title: music[:title], playtype: playtype, difficulty: music[:difficulty]).first
      score = scores.select{|x| x.title == music[:title] && x.playtype == playtype && x.difficulty == music[:difficulty] }.first
      next unless score
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
    score_power_string = "%.2f" % score_power
    [score_power_string, title]
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
    scores = Score.where(iidxid: iidxid)
    Music.where(playtype: playtype, level: level.to_s).each do |music|
      score = scores.select{|x| x.title == music[:title] && x.playtype == playtype && x.difficulty == music[:difficulty] }.first
      next unless score
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
    "%.2f" % score_power
  end
end
