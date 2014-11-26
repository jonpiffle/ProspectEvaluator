class Player < ActiveRecord::Base
    has_many :news
    has_many :tweets
    has_many :tweet_abouts

    def keyword_array
        eval(keywords.gsub("(u", "[").gsub(")", "]").gsub("(", "["))
    end

    def get_color(number)
        number >= 0 ? "Green" : "Red"
    end

    def get_sign(number)
        number >= 0 ? "+" : ""
    end
end
