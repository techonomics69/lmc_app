class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
    	t.belongs_to :member, index: true, foreign_key: true
      t.string :template
      t.string :subject
      t.string :body
      t.string :sent_to

      t.timestamps
    end
  end
end
