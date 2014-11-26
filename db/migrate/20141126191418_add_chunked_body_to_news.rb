class AddChunkedBodyToNews < ActiveRecord::Migration
  def change
    add_column :news, :chunked_body, :text
  end
end
