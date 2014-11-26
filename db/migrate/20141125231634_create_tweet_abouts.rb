class CreateTweetAbouts < ActiveRecord::Migration
  def change
    create_table :tweet_abouts do |t|
      t.string :text
      t.string :tweet_id
      t.datetime :tweet_time
      t.string :tweeted_by

      t.timestamps
    end
  end
end
