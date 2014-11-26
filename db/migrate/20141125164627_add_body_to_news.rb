class AddBodyToNews < ActiveRecord::Migration
  def change
    add_column :news, :body, :text
  end
end
