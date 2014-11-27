require 'faraday'
require 'json'
require 'pry'

#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

players = Player.all
players.each do |player|
    connection = Faraday.new "https://api.datamarket.azure.com/Bing/Search/v1/News?Query=%27#{URI::encode(player.name)}%27&NewsCategory=%27rt_Sports%27&$top=50&$format=json"
    connection.basic_auth "", "HsqqKoxikBuWCZV/YJ8cg1x4bcaQ7Oh0/S32K4kUanI"
    response = connection.get

    body_hash = JSON.parse(response.body)
    results = body_hash['d']['results']

    results.each do |result|
        news = player.news.create(
            :url => result['Url'],
            :title => result['Title'],
            :source => result['Source'],
            :description => result['Description'],
            :date_posted => result['Date']
        )
        print news.inspect
    end
end
