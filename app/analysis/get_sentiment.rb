require 'sentimental'

#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

Sentimental.load_defaults
analyzer = Sentimental.new

News.all.each do |article|
    article.sentiment_score = analyzer.get_score(article.body)
    article.save
end

Tweet.all.each do |tweet|
    tweet.sentiment_score = analyzer.get_score(tweet.text)
    tweet.save
end

TweetAbout.all.each do |tweet|
    tweet.sentiment_score = analyzer.get_score(tweet.text)
    tweet.save
end