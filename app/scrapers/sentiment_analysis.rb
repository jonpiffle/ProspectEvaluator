require 'sentimental'
require 'pry'

Sentimental.load_defaults
Sentimental.threshold = 0.1

analyzer = Sentimental.new

binding.pry