class StaticPagesController < ApplicationController
	require 'icalendar/tzinfo'
	require 'tzinfo'
  require 'open-uri'
  require 'nokogiri'
	
	include StaticPagesHelper

  def home
  	@meets = next_meets
    @bb_feed = bb_feed if @bb_feed.nil?
    @meta_description = meta_description("home")
  end

  def benefits
    @meta_description = meta_description("benefits")
  end

  def booking
    @meta_description = meta_description("booking")
  end

  def calendar
    @future_meets = all_future_meets
    @past_meets = past_meets
    @meta_description = meta_description("calendar")
  end

  def contact
    @meta_description = meta_description("contact")
  end

  def galleries
    @meta_description = meta_description("galleries")
  end

  def handbook
    @meta_description = meta_description("handbook")
  end

  def help
    @meta_description = meta_description("help")
  end

  def history
  end

  def archives
  end

  def cae_amos
  end

  def links
    @meta_description = meta_description("links")
  end

  def meets
    @future_meets = all_future_meets
    @meta_description = meta_description("meets")
  end

  def membership
    @meta_description = meta_description("membership")
  end  

  def pay
    @meta_description = meta_description("pay")
  end

  def privacy_policy
    @meta_description = meta_description("privacy_policy")
  end

  def the_committee
    @meta_description = meta_description("the_committee")
  end

  def handbook_download
    send_file(
      "#{Rails.root}/public/LMC_Handbook_May2018.pdf",
      filename: "LMC Constitution and Handbook.pdf",
      type: "application/pdf"
    )
  end
end