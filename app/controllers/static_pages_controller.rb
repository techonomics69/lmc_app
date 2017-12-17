class StaticPagesController < ApplicationController
	include StaticPagesHelper
  def home
  	@future_meets = future_meets
  end

  def help
  end

  def membership
  end
  
end
