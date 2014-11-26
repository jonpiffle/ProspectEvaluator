class AddTweetUniqueness < ActiveRecord::Migration
  def change
    add_index :tweets, [:text], unique: true
    add_index :tweet_abouts, [:text], unique: true
  end
end
