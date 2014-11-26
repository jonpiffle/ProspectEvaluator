class AddUniqueness < ActiveRecord::Migration
  def change
    add_index :news, [:url], unique: true
    add_index :tweets, [:tweet_id], unique: true
    add_index :tweet_abouts, [:tweet_id], unique: true
  end
end
