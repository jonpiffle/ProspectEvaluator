class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.string :tweet_id
      t.datetime :tweet_time

      t.timestamps
    end
  end
end
