class AddSubsPaidToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :subs_paid, :boolean, default: false
  end
end
