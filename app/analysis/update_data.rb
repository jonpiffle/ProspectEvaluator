#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

#Get news
puts "Scraping News Articles"
`ruby ../scrapers/bing_search.rb`

#Pull news articles
puts "Extracting text from articles"
News.where("news.html is NULL").each do |n|
    n.scrape_html
end

#Store pos tagged copy of news articles
puts "POS-tagging articles"
`python chunk_news.py`

#Find and store keywords using tf-idf
puts "Extracting keywords from articles"
`python get_keywords.py`

#Make sure all news is stored in correct encoding
puts "Checking text encoding of keywords"
`ruby ../scrapers/convert_to_utf_8.rb`

#Get tweets
puts "Scraping tweets"
`python get_tweets.py`

#Run sentiment analysis on news and tweets
puts "Running sentiment analysis on articles and tweets"
`ruby get_sentiment.rb`

#Store avg sentiment analysis score and rank for each player
puts "Computing sentiment scores and ranks for each player"
`ruby get_player_sentiment.rb`
