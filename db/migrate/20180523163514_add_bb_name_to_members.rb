class AddBbNameToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :bb_name, :string
  end
end
