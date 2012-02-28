# URLnip
# Takes a url as argument in a RESTfull...ish way and shorten it.
# Coded by Werner Gillmer <werner.gillmer@gmail.com>

require 'rubygems'
require 'sinatra/base'
require 'securerandom'
require 'mongo_mapper'

# TODO - Get this vars from ENV var values
mongo_server = '127.0.0.1' 
mongo_database = 'URLnip'

MongoMapper.connection = Mongo::Connection.new(mongo_server)
MongoMapper.database = mongo_database

# DB model
class Surl 
  include MongoMapper::Document

  key :url_key, String, :required => true
  key :url, String, :required => true
  #key :when, Time.now
  timestamps!
end

# Main worker class
class UrlNip < Sinatra::Base

  # TODO - Get this car from ENV var value 
  domain = 'afri.gis'

  #get '/?' do
  #  return "Usage : http://#{domain}/shorten/URL you want to shorten"
  #end

  # Beta functionality for shorten call 
  #get '/beta/:url' do |url|
  get '/?' do 
   erb :index
  end 

  get '/shorten/?' do
    random_string = SecureRandom.hex(2)
    shorten_url = "http://#{domain}/#{random_string}"
  
      url = params[:url]
      nipurl = Surl.create(:url_key => random_string, :url => url)
      nipurl.save!
      return "And your URL is : #{shorten_url}"
  end

  get '/:urlkey/?' do |urlkey|
     redirect_url = Surl.find_by_url_key(urlkey)
     redirect "http://#{redirect_url.url}"
  end

end
