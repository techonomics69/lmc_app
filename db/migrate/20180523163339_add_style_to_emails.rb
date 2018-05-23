class AddStyleToEmails < ActiveRecord::Migration[5.1]
  def change
    add_column :emails, :style, :string
  end
end
