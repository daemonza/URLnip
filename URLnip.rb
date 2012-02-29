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
  timestamps!
end

# Main worker class
class UrlNip < Sinatra::Base

  # TODO - Get this car from ENV var value 
  domain = 'afri.gis'

  # Shows form where you give a URL to shorten. and then pass
  # that URL to /shorten 
  get '/?' do 
   erb :index
  end

  # Does the heavy lifting. Shorten the URL and put it in
  # Mongo, and display shorty page with shortened URL 
  get '/shorten/?' do
    random_string = SecureRandom.hex(2)
    shorten_url = "http://#{domain}/#{random_string}"

      url = params[:url]
      nipurl = Surl.create(:url_key => random_string, :url => url)
      nipurl.save!
      @shorty = shorten_url
      erb :shorty
      #return "And your URL is : #{shorten_url}"
  end

  # Does the re-direct 
  get '/:urlkey/?' do |urlkey|
     redirect_url = Surl.find_by_url_key(urlkey)
     # BUG : if you put http:// in the url to shorten, the redirect breaks.
     #redirect "http://#{redirect_url.url}"
     redirect "#{redirect_url.url}"
  end
end
