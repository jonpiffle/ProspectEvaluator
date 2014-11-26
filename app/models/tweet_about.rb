require 'sentimental'

class TweetAbout < ActiveRecord::Base
    belongs_to :player
    validates :tweet_id, uniqueness: true
end
