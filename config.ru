# Rack config.ru
# Coded by Werner Gillmer <werner.gillmer@gmail.com>

require 'sinatra'
require 'rubygems'
require './URLnip'

# run Sinatra::Application # Use this when using passenger/unicorn/etc
run UrlNip.new!
