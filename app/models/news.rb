require 'open-uri'

class News < ActiveRecord::Base
    belongs_to :player
    validates :url, uniqueness: true
    after_create :scrape_html

    def scrape_html
        begin
            html = open(self.url).read()
            body = Pismo::Document.new(html).body
            self.update_attributes(:html => html, :body => body)
        rescue
            self.destroy
        end
    end
end
