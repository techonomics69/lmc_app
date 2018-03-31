class AddDefaultTemplateToEmails < ActiveRecord::Migration[5.1]
  def change
  	add_column :emails, :default_template, :boolean, default: false
  	add_column :emails, :sent_on, :datetime
  end
end
