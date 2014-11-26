class AddForeignKeyToTweetTables < ActiveRecord::Migration
  def change
    add_column :tweets, :player_id, :integer
    add_column :tweet_abouts, :player_id, :integer
  end
end
