class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :position
      t.string :hometown
      t.string :college_class
      t.string :reach
      t.string :wingspan
      t.string :age
      t.string :date_of_birth
      t.string :college
      t.string :height
      t.string :weight
      t.string :photo_url
      t.string :espn_overall_rank
      t.string :espn_position_rank

      t.timestamps
    end
  end
end
