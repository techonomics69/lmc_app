class StaticPagesController < ApplicationController
	require 'icalendar/tzinfo'
	require 'tzinfo'
  require 'open-uri'
  require 'nokogiri'
	
	include StaticPagesHelper

  def home
  	@meets = next_meets
    @bb_feed = bb_feed
  end

  def help
  end

  def membership
  end

  def calendar
  	@meets = all_future_meets
  end

  def pay
  end


end