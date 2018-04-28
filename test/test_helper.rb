ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :members, :memberships, :meets, :emails, :emergency_contacts
  include ApplicationHelper
  
  def is_logged_in?
  	!session[:member_id].nil?
  end

  def log_in_as(member)
  	sessions[:member_id] = member.member_id
  end
end

class ActionDispatch::IntegrationTest
  fixtures :members, :memberships, :meets, :emails, :emergency_contacts
	def log_in_as(member, password: 'password')
		post login_path, params: { session: { email: member.email,
																					password: password, } }
	end
end
