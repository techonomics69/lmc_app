class AddOpensOnToMeets < ActiveRecord::Migration[5.1]
  def change
    add_column :meets, :opens_on, :date
    remove_reference :meets, :members, index: true, foreign_key: true
    remove_column :meets, :member_id
  end
end
