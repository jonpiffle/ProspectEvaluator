require 'io/console'
require 'rubygems'
require 'mechanize'
require 'pry'
require 'set'

#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

#Get ESPN Insider Credentials
puts "Enter Insider email:"
email = gets.strip

puts "Enter Insider password"
password = STDIN.noecho(&:gets).chomp

#Login to ESPN Insider
a = Mechanize.new
page = a.post(
    "https://r.espn.go.com/members/util/loginUser",
    {
        "username" => email,
        "password" => password,
        "registrationFormId" => "espn_insider",
        "affiliateName" => "espn_insider",
        "appRedirect" => "http://insider.espn.go.com/insider/benefits",
        "parentLocation" => "http://insider.espn.go.com/insider/benefits"
    }
)

#Collect top 100 player urls
player_urls = Set.new
5.times do |i|
    page = a.get("http://insider.espn.go.com/nbadraft/results/top100/_/year/2015/set/#{i}")
    page_links = page.links.select{|p| p.uri.to_s[%r"/insider.espn.go.com/nbadraft/results/players/_/id/"]}
    player_urls.merge(page_links.map{|p| p.href})
end

#Visit each player page and collect data
player_urls.each do |url|
    begin
        page = a.get(url)
        player_bio = page.search('div.player-bio')
        name = player_bio.search('h1').text
        puts name

        position, height_weight, college = player_bio.search("ul.general-info li").map {|i| i.text}
        height, weight = height_weight.split(", ")

        age, dob, city, c_class, reach, span = player_bio.search("ul.player-metadata li").map {|l| l.children.last.text}
        
        img_url = player_bio.search("div.main-headshot-65 img").first.attributes['src'].value

        overall_rank = page.search('table.tablehead tr')[0].search('td').last.text
        position_rank = page.search('table.tablehead tr')[1].search('td').last.text

        p = Player.create(
            position: position,
            hometown: city,
            college_class: c_class,
            reach: reach,
            wingspan: span, 
            age: age,
            date_of_birth: dob,
            college: college,
            height: height,
            weight: weight,
            photo_url: img_url,
            espn_overall_rank: overall_rank,
            espn_position_rank: position_rank,
            name: name
        )
    rescue
        next
    end
end
