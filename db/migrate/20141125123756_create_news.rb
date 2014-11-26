class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :url
      t.string :title
      t.string :source
      t.text :description
      t.integer :player_id
      t.datetime :date_posted

      t.timestamps
    end
  end
end
