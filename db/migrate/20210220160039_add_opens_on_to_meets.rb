class AddOpensOnToMeets < ActiveRecord::Migration[5.1]
  def change
    add_column :meets, :opens_on, :date
    remove_column :meets, :member_id
  end
end
