# Rack config.ru
# Coded by Werner Gillmer <werner.gillmer@gmail.com>

require 'rubygems'
require 'sinatra'
require './URLnip'

# run Sinatra::Application # Use this when using passenger
run UrlNip.new!
