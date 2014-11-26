class AddHtmlToNews < ActiveRecord::Migration
  def change
    add_column :news, :html, :text
  end
end
