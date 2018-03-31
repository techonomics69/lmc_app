class Email < ApplicationRecord

	belongs_to :member, optional: true
	
	validates :template, presence: true
	validates :subject, presence: true
	validates :body, presence: true
	validates :default_template, inclusion: { in: [ true, false ] }
	
end
