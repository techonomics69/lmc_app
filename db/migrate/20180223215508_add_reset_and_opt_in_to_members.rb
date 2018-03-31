class AddResetAndOptInToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :reset_digest, :string
    add_column :members, :reset_sent_at, :datetime
    add_column :members, :receive_emails, :boolean, default: true
  end
end
