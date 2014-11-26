class AddSentimentScoresAndRanksToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :news_sentiment, :float
    add_column :players, :tweet_sentiment, :float
    add_column :players, :tweet_about_sentiment, :float
    add_column :players, :news_sentiment_rank, :integer
    add_column :players, :tweet_sentiment_rank, :integer
    add_column :players, :tweet_about_sentiment_rank, :integer
  end
end
