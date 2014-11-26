#Load rails environment
ENV['RAILS_ENV'] = ARGV[0] || 'development'
DIR = File.dirname(__FILE__) 
require DIR + '/../../config/environment'

doc = Pismo::Document.new("http://www.syracuse.com/orangebasketball/index.ssf/2014/11/miamis_angel_rodriguez_dukes_jahlil_okafor_earn_acc_weekly_honors.html")
puts doc.body