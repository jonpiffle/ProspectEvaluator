class AddSentimentToTweetsAndArticles < ActiveRecord::Migration
  def change
    add_column :tweets, :sentiment_score, :float
    add_column :tweet_abouts, :sentiment_score, :float
    add_column :news, :sentiment_score, :float
  end
end
