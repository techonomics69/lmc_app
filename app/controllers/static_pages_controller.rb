class StaticPagesController < ApplicationController
  require 'icalendar/tzinfo'
  require 'tzinfo'
  require 'open-uri'
  require 'nokogiri'

  include StaticPagesHelper
  include MeetsHelper

  # helper_method :find_meet_leader

  skip_before_action :session_expires
  # after_action :allow_youtube_iframe# only: :home

  def home
    @meets = next_meets
    @bb_feed = bb_feed
    @meta_description = meta_description('home')
  end

  def benefits
    @meta_description = meta_description('benefits')
  end

  def booking
    @meta_description = meta_description('booking')
  end

  def calendar
    @member = current_user if logged_in?
    @future_meets = all_future_meets
    @past_meets = past_meets
    @meta_description = meta_description('calendar')
  end

  def contact
    @meta_description = meta_description('contact')
  end

  def galleries
    @meta_description = meta_description('galleries')
  end

  def handbook
    @meta_description = meta_description('handbook')
  end

  def help
    @meta_description = meta_description('help')
  end

  def history; end

  def archives; end

  def cae_amos; end

  def links
    @meta_description = meta_description('links')
  end

  def meets
    @future_meets = all_future_meets
    @meta_description = meta_description('meets')
  end

  def membership
    @meta_description = meta_description('membership')
  end

  def pay
    @meta_description = meta_description('pay')
  end

  def privacy_policy
    @meta_description = meta_description('privacy_policy')
  end

  def the_committee
    @meta_description = meta_description('the_committee')
  end

  def handbook_download
    send_file(
      "#{Rails.root}/public/LMC-Constitution-and-Handbook-September-2019.pdf",
      filename: 'LMC Constitution and Handbook.pdf',
      type: 'application/pdf'
    )
  end

  # def allow_youtube_iframe
  #   response.headers['X-Frame-Options'] = 'ALLOW-FROM https://www.youtube.com/'
  # end
end
