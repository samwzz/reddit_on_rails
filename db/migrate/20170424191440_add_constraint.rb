class AddConstraint < ActiveRecord::Migration[5.0]
  def change
    remove_column :subs, :mod_id
    add_column :subs, :mod_id, :integer, null: false
  end
end
