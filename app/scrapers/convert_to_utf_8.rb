ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

keys = News.new.attributes.keys
News.all.each do |n|
    keys.each do |key|
        value = n.send(key)
        if value.class.to_s == "String"
            n.send("#{key}=", value.encode("ASCII", :invalid => :replace, :undef => :replace, :replace => ""))
        end
        n.save!
    end
end
