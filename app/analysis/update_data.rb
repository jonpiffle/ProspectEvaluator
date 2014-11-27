#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

#Get news
`ruby ../scrapers/bing_search.rb`

#pull news articles
News.where("news.html is NULL").each do |n|
    n.scrape_html
end

#Store pos tagged copy of news articles
`python chunk_news.py`

#Find and store keywords using tf-idf
`python get_keywords.py`

#Make sure all news is stored in correct encoding
`ruby convert_to_utf_8.rb`

#Get tweets
`python get_tweets.py`

#Run sentiment analysis on news and tweets
`ruby get_sentiment.rb`

#Store avg sentiment analysis score and rank for each player
`ruby get_player_sentiment.rb`
