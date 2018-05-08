class StaticPagesController < ApplicationController
	require 'icalendar/tzinfo'
	require 'tzinfo'
  require 'open-uri'
  require 'nokogiri'
	
	include StaticPagesHelper

  def home
  	@meets = next_meets
    @bb_feed = bb_feed if @bb_feed.nil?
  end

  def benefits
  end

  def pay
  end

  def handbook
  end

  def handbook_download
    send_file(
      "#{Rails.root}/public/LMC_Handbook_May2018.pdf",
      filename: "LMC Constitution and Handbook.pdf",
      type: "application/pdf"
  )
  end

  def membership
  end

  def meets
  	@future_meets = all_future_meets
  end

  def calendar
    @future_meets = all_future_meets
    @past_meets = past_meets
  end

  def booking
  end

  def galleries
  end

  def privacy_policy
  end


end