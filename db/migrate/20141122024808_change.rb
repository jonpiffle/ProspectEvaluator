class Change < ActiveRecord::Migration
  def change
    add_column :players, :name, :string
    remove_column :players, :first_name
    remove_column :players, :last_name
  end
end
