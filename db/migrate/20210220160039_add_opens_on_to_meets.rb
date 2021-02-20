class AddOpensOnToMeets < ActiveRecord::Migration[5.1]
  def change
    add_column :meets, :opens_on, :date
  end
end
