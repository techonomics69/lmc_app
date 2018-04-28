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

  def help
  end

  def membership
  end

  def when_and_where
  	@future_meets = all_future_meets
  end

  def calendar
    @future_meets = all_future_meets
    @past_meets = past_meets
  end

  def pay
  end


end