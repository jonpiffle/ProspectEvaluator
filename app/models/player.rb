class Player < ActiveRecord::Base
    has_many :news
    has_many :tweets
    has_many :tweet_abouts
end
