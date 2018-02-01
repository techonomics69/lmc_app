class StaticPagesController < ApplicationController
	require 'icalendar/tzinfo'
	require 'tzinfo'
	
	include StaticPagesHelper

  def home
  	@meets = next_meets
  end

  def help
  end

  def membership
  end

  def calendar
  	@meets = all_future_meets
  end


end