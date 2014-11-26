#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

def mean(arr)
    if arr.count > 0
        return arr.sum / arr.count.to_f
    else
        return 0
    end
end

players = Player.all.to_a

players.each do |player|
    player.news_sentiment = mean(player.news.map {|n| n.sentiment_score})
    player.tweet_sentiment = mean(player.tweets.map {|t| t.sentiment_score})
    player.tweet_about_sentiment = mean(player.tweet_abouts.map {|t| t.sentiment_score})
end

players.sort {|b, a| a.news_sentiment <=> b.news_sentiment}.each_with_index do |p, i|
    p.news_sentiment_rank = i + 1
end

players.sort {|b, a| a.tweet_sentiment <=> b.tweet_sentiment}.each_with_index do |p, i|
    p.tweet_sentiment_rank = i + 1
end

players.sort {|b, a| a.tweet_about_sentiment <=> b.tweet_about_sentiment}.each_with_index do |p, i|
    p.tweet_about_sentiment_rank = i + 1
end

players.each {|p| p.save}