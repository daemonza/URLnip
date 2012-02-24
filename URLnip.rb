# URLnip
# Takes a url as argument in a RESTfull...ish way and shorten it.
# Coded by Werner Gillmer <werner.gillmer@gmail.com>

require 'rubygems'
require 'sinatra/base'
require 'securerandom'
require 'mongo_mapper'
require 'json'

mongo_server = '127.0.0.1' # Get this from ENV var
mongo_database = 'URLnip' # get this from ENV var


MongoMapper.connection = Mongo::Connection.new(mongo_server)
MongoMapper.database = mongo_database

# DB model
class Surl 
  include MongoMapper::Document

  key :url_key, String, :required => true
  key :url, String, :required => true
#  key :when, Time.now
end


# Main worker class
class UrlNip < Sinatra::Base

  domain = 'afri.gis' # Get this from a ENV var.

  get '/' do
    return "Usage : http://#{domain}/shorten/URL you want to shorten"
  end

  get '/shorten/:url' do |url|
    random_string = SecureRandom.hex(2)
    shorten_url = "http://#{domain}/#{random_string}"

   nipurl = Surl.create(:url_key => random_string, :url => url)
   nipurl.save!
  
    return "And your URL is : #{shorten_url}"
  end

  get '/:urlkey' do |urlkey|
     redirect_url = Surl.find_by_url_key(urlkey)
     redirect "http://#{redirect_url.url}"
  end
end
