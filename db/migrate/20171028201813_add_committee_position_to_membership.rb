class AddCommitteePositionToMembership < ActiveRecord::Migration[5.1]
  def change
  	add_column :memberships, :committee_position, :string
  end
end
